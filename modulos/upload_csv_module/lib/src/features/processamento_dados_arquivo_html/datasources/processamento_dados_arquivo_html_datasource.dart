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
          final remessa = RemessaModel(
            nomeArquivo: mapRemessa["arquivo"]["nome do arquivo"],
            data: mapRemessa["arquivo"]["data da remessa"],
            remessa: await _processamentoBoleto(
              listaBruta: mapRemessa["arquivo"]["remessa"],
            ),
          );
          remessasProcessadas.add(remessa);
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
  required List<Map<String, String>> listaBruta,
}) async {
  List<BoletoModel> boletos = [];

  if (listaBruta.isNotEmpty) {
    for (Map<String, String> boleto in listaBruta) {
      BoletoModel model = BoletoModel.fromMap(boleto);
      boletos.add(model);
    }
    return boletos;
  } else {
    throw Exception("Erro ao processar arquivo");
  }
}
