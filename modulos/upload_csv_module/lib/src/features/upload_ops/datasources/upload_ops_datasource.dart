import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_csv_module.dart';

class UploadOpsDatasource
    implements Datasource<Map<String, List<BoletoModel>>> {
  @override
  Future<Map<String, List<BoletoModel>>> call(
      {required ParametersReturnResult parameters}) {
    try {
      if (parameters is ParametrosUploadBoleto) {
        List<BoletoModel> listBoletosNovos = [];
        for (BoletoModel boleto in parameters.listaBoletosCarregados) {
          listBoletosNovos.add(boleto);
        }
        return Future.value({
          "listOpsNovas": listBoletosNovos,
        });
      } else {
        throw Exception("Erro ao fazer a triagem dos Boletos");
      }
    } catch (e) {
      throw Exception("Erro ao fazer a triagem dos Boletos");
    }
  }
}
