import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametos.dart';

class ProcessarCsvEmOpsDatasource implements Datasource<RemessaModel> {
  @override
  Future<RemessaModel> call(
      {required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosProcessarCsvEmRemessa) {
        final DateTime dataProcessada = DateTime.parse(
          "${parameters.listaBruta[1].last.substring(6, 10)}-${parameters.listaBruta[1].last.substring(3, 5)}-${parameters.listaBruta[1].last.substring(0, 2)}",
        );
        final remessa = RemessaModel(
          nomeArquivo: parameters.listaBruta[0][0],
          data: dataProcessada,
          remessa: await _processamentoBoleto(
            listaBruta: parameters.listaBruta,
          ),
        );
        return remessa;
      } else {
        throw Exception("Erro ao processar arquivo");
      }
    } catch (e) {
      throw Exception("Erro ao processar arquivo");
    }
  }
}

Future<List<BoletoModel>> _processamentoBoleto({
  required List<List<dynamic>> listaBruta,
}) async {
  List<BoletoModel> boletos = [];
  List<List<dynamic>> listaDados = [];
  List<dynamic> cabecario = listaBruta[2];
  listaDados.addAll(listaBruta);

  listaDados.removeRange(0, 3);

  if (listaDados.isNotEmpty) {
    for (List<dynamic> lista in listaDados) {
      Map<String, String> modelJason = {};
      for (dynamic item in lista) {
        int indexL = lista.indexOf(item);
        modelJason.addAll({"${cabecario[indexL]}": "$item"});
      }
      final key1 = modelJason.keys.first;
      final value1 = int.tryParse(modelJason['ID Cliente'].toString());
      if (key1 == 'ID Cliente' && value1 != null && value1 > 0) {
        BoletoModel model = BoletoModel.fromMap(modelJason);
        boletos.add(model);
      }
    }
    return boletos;
  } else {
    throw Exception("Erro ao processar arquivo");
  }
}
