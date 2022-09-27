import 'package:dependencies_module/dependencies_module.dart';
import 'dart:convert' as convert;

import '../../../utils/parametros/parametros_upload_csv_module.dart';

class MapeamentoDadosArquivoHtmlDatasource
    implements Datasource<List<Map<String, List<Map<String, dynamic>>>>> {
  @override
  Future<List<Map<String, List<Map<String, dynamic>>>>> call(
      {required ParametersReturnResult parameters}) async {
    if (parameters is ParametrosMapeamentoArquivoHtml) {
      List<Map<String, Uint8List>> mapBytes = parameters.listaMapBytes;

      if (mapBytes.isNotEmpty) {
        List<Map<String, List<Map<String, dynamic>>>> listaArquivos = [];
        for (Map<String, Uint8List> map in mapBytes) {
          final Map<String, List<Map<String, dynamic>>> mapArquivo = {
            "arquivo": _listaProcessada(map: map),
          };
          listaArquivos.add(mapArquivo);
        }
        return listaArquivos;
      } else {
        throw Exception(
            "Erro ao mapear as informaões do arquivo - ${parameters.error}");
      }
    } else {
      throw Exception(
          "Erro ao mapear as informaões do arquivo - - ${parameters.error}");
    }
  }

  List<Map<String, dynamic>> _listaProcessada({
    required Map<String, Uint8List> map,
  }) {
    if (map.keys.first.contains(".csv")) {
      return _processamentoCsv(
        map: map,
      );
    } else if (map.keys.first.contains(".xlsx")) {
      return _processamentoXlsx(
        map: map,
      );
    } else {
      throw Exception("Arquivo carregado precisa ter extenção xlsx ou csv");
    }
  }

  List<Map<String, dynamic>> _processamentoXlsx({
    required Map<String, Uint8List> map,
  }) {
    var decoder = SpreadsheetDecoder.decodeBytes(map.values.first);
    List<List<dynamic>> listXlsx = [];
    List<Map<String, dynamic>> mapXlsx = [];
    List<List<dynamic>> listaDados = [];
    List<Map<String, dynamic>> mapDados = [];

    listXlsx.addAll(decoder.tables[decoder.tables.keys.first]!.rows);

    mapXlsx.add({"nome do arquivo": map.keys.first});

    final DateTime dataProcessada = DateTime.parse(listXlsx[0].last);
    mapXlsx.add({"data da remessa": dataProcessada});

    listaDados.addAll(listXlsx);
    listaDados.removeRange(0, 2);

    if (listaDados.isNotEmpty) {
      final List<dynamic> cabecario = listXlsx[1];
      for (List<dynamic> lista in listaDados) {
        Map<String, dynamic> modelJason = {};
        for (dynamic item in lista) {
          int indexL = lista.indexOf(item);
          modelJason.addAll({"${cabecario[indexL]}": "$item"});
        }
        final key1 = modelJason.keys.first;
        final value1 = int.tryParse(modelJason['ID Cliente'].toString());
        if (key1 == 'ID Cliente' && value1 != null && value1 > 0) {
          mapDados.add(modelJason);
        }
      }
    }
    mapXlsx.add({"remessa": mapDados});
    return mapXlsx;
  }

  List<Map<String, dynamic>> _processamentoCsv(
      {required Map<String, Uint8List> map}) {
    final decoderByte = convert.latin1.decode(map.values.first);
    List<List<dynamic>> listCsv = [];
    List<List<dynamic>> listaDados = [];
    List<Map<String, dynamic>> mapCsv = [];
    List<Map<String, dynamic>> mapDados = [];

    listCsv.addAll(
        const CsvToListConverter(fieldDelimiter: ";").convert(decoderByte));

    mapCsv.add({"nome do arquivo": map.keys.first});
    final DateTime dataProcessada = DateTime.parse(
      "${listCsv[0].last.substring(6, 10)}-${listCsv[0].last.substring(3, 5)}-${listCsv[0].last.substring(0, 2)}",
    );
    mapCsv.add({"data da remessa": dataProcessada});

    listaDados.addAll(listCsv);
    listaDados.removeRange(0, 2);
    if (listaDados.isNotEmpty) {
      List<dynamic> cabecario = listCsv[1];
      for (List<dynamic> lista in listaDados) {
        Map<String, dynamic> modelJason = {};
        for (dynamic item in lista) {
          int indexL = lista.indexOf(item);
          modelJason.addAll({"${cabecario[indexL]}": "$item"});
        }
        final key1 = modelJason.keys.first;
        final value1 = int.tryParse(modelJason['ID Cliente'].toString());
        if (key1 == 'ID Cliente' && value1 != null && value1 > 0) {
          mapDados.add(modelJason);
        }
      }
    }
    mapCsv.add({"remessa": mapDados});
    return mapCsv;
  }
}
