import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_remessa_module.dart';

class ProcessamentoDadosArquivoHtmlDatasource
    implements Datasource<Map<String, List<RemessaModel>>> {
  @override
  Future<Map<String, List<RemessaModel>>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosProcessamentoArquivoHtml) {
        List<RemessaModel> remessasProcessadas = [];
        List<RemessaModel> remessasProcessadasError = [];
        for (Map<String, dynamic> mapRemessa in parameters.listaMapBruta) {
          final String nomeArquivo = mapRemessa["arquivo"]["nome do arquivo"];
          final List<Map<String, String>> listaBruta =
              mapRemessa["arquivo"]["remessa"];

          final DateTime data = mapRemessa["arquivo"]["data da remessa"];

          if (listaBruta.isNotEmpty) {
            final remessa = RemessaModel(
              nomeArquivo: nomeArquivo,
              data: data,
              upload: DateTime.now(),
              remessa: await _processamentoBoleto(
                listaBruta: listaBruta,
              ),
            );
            remessasProcessadas.add(remessa);
          } else {
            final remessa = RemessaModel(
              nomeArquivo: nomeArquivo,
              data: data,
              upload: DateTime.now(),
              remessa: <BoletoModel>[],
            );
            remessasProcessadasError.add(remessa);
          }
        }
        final Map<String, List<RemessaModel>> remessas = {
          "remessasProcessadas": remessasProcessadas,
          "remessasProcessadasError": remessasProcessadasError,
        };

        return remessas;
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
      BoletoModel model = BoletoModel.fromMapBase(boleto);
      boletos.add(model);
    }
    // print("*******");
    // print(boletos);
    // print("*******");
    return boletos;
  } else {
    throw Exception("Erro ao processar arquivo");
  }
}
