import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_csv_module.dart';

class ProcessamentoDadosArquivoHtmlDatasource
    implements Datasource<List<RemessaModel>> {
  @override
  Future<List<RemessaModel>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosProcessamentoArquivoHtml) {
        List<RemessaModel> remessasProcessadas = [];
        for (Map<String, dynamic> mapRemessa in parameters.listaMapBruta) {
          print(mapRemessa["arquivo"][2]["remessa"].runtimeType);
          final remessa = RemessaModel(
            nomeArquivo: mapRemessa["arquivo"][0]["nome do arquivo"],
            data: mapRemessa["arquivo"][1]["data da remessa"],
            remessa: await _processamentoBoleto(
              listaBruta: mapRemessa["arquivo"][2]["remessa"],
            ),
          );
          print(remessa);
        }

        return remessasProcessadas;
      } else {
        throw Exception("Erro ao processar arquivo");
      }
    } catch (e) {
      throw Exception("Erro ao processar arquivo");
    }
  }
}

Future<List<BoletoModel>> _processamentoBoleto({
  required List<Map<String, dynamic>> listaBruta,
}) async {
  List<BoletoModel> boletos = [];

  if (listaBruta.isNotEmpty) {
    for (Map<String, dynamic> boleto in listaBruta) {
      BoletoModel model = BoletoModel.fromMap(boleto);
      boletos.add(model);
    }
    return boletos;
  } else {
    throw Exception("Erro ao processar arquivo");
  }
}
