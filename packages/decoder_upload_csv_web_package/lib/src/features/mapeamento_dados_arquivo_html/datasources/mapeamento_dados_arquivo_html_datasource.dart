import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert' as convert;

import '../../../utils/parametros/parametos.dart';

class MapeamentoDadosArquivoHtmlDatasource
    implements Datasource<List<Map<String, dynamic>>> {
  @override
  Future<List<Map<String, dynamic>>> call(
      {required ParametersReturnResult parameters}) async {
    if (parameters is ParametrosListarDadosRemessa) {
      List<html.File>? files = parameters.listaBruta;

      if (files.isNotEmpty) {
        List<Map<String, dynamic>> listaGeral = [];
        for (html.File file in files) {
          listaGeral.addAll(await _listaBruta(file: file));
        }
        return listaGeral;
      } else {
        throw Exception("Erro ao carregar arquivo");
      }
    } else {
      throw Exception("Erro ao carregar arquivo");
    }
  }

  Future<List<Map<String, dynamic>>> _listaBruta({required html.File file}) {
    final reader = html.FileReader();

    final resultReader = reader.onLoadEnd.first.then((_) {
      Object? result = reader.result;
      String s = result.toString();
      String base64 = s.substring(s.indexOf(",") + 1);
      final bytes = convert.base64.decode(base64);

      if (file.name.contains(".csv")) {
        return _processamentoCsv(
          bytes: bytes,
          nomeDoArquivo: file.name,
        );
      } else if (file.name.contains(".xlsx")) {
        return _processamentoXlsx(
          bytes: bytes,
          nomeDoArquivo: file.name,
        );
      } else {
        throw Exception("Arquivo carregado precisa ter extenção xlsx ou csv");
      }
    });

    reader.readAsDataUrl(file);

    return resultReader;
  }

  List<Map<String, dynamic>> _processamentoXlsx({
    required Uint8List bytes,
    required String nomeDoArquivo,
  }) {
    var decoder = SpreadsheetDecoder.decodeBytes(bytes);
    List<List<dynamic>> listaDados = [];
    List<Map<String, dynamic>> mapXlsx = [];
    List<List<dynamic>> listXlsx = [];
    List<Map<String, dynamic>> mapDados = [];

    listXlsx.addAll(decoder.tables[decoder.tables.keys.first]!.rows);

    mapXlsx.add({"nome do arquivo": nomeDoArquivo});

    final DateTime dataProcessada = DateTime.parse(listXlsx[0].last);
    mapXlsx.add({"data da remessa": dataProcessada});

    listaDados.addAll(listXlsx);
    listaDados.removeRange(0, 2);

    if (listaDados.isNotEmpty) {
      List<dynamic> cabecario = listXlsx[1];
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
    print("***********");
    print(mapXlsx);
    print("***********");

    return mapXlsx;
  }
}

List<Map<String, dynamic>> _processamentoCsv({
  required Uint8List bytes,
  required String nomeDoArquivo,
}) {
  final decoderByte = convert.latin1.decode(bytes);
  List<List<dynamic>> listCsv = [];
  List<List<dynamic>> listaDados = [];
  List<Map<String, dynamic>> mapCsv = [];
  List<Map<String, dynamic>> mapDados = [];

  listCsv.addAll(
      const CsvToListConverter(fieldDelimiter: ";").convert(decoderByte));

  mapCsv.add({"nome do arquivo": nomeDoArquivo});
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
  print("***********");
  print(mapCsv);
  print("***********");

  return mapCsv;
}
