import 'package:dependencies_module/dependencies_module.dart';

import '../features/carregar_csv/datasources/upload_csv_html_datasource.dart';
import '../features/carregar_csv/domain/usecase/carregar_csv_usecase.dart';
import '../features/processar_csv/datasources/processar_csv_em_remessa_datasource.dart';
import '../features/processar_csv/domain/usecase/processar_csv_usecase.dart';
import '../utils/parametros/parametos.dart';

class CarregarCsvPresenter implements Presenter {
  @override
  Future<ReturnSuccessOrError> call(
      {required ParametersReturnResult parameters}) async {
    final remessa = await _processarRemessa(
      listaCsv: await _carregarCsv(
        parameters: parameters,
      ),
      parameters: parameters,
    );

    return remessa;
  }

  Future<List<List<dynamic>>> _carregarCsv(
      {required ParametersReturnResult parameters}) async {
    final stringList = await CarregarCsvUsecase(
      datasource: UploadCsvHtmlDatasource(),
    )(
      parameters: parameters,
    );

    if (stringList.status == StatusResult.success) {
      return stringList.result;
    } else {
      throw Exception("Erro ao carregar arquivo");
    }
  }

  Future<ReturnSuccessOrError<RemessaModel>> _processarRemessa({
    required List<List<dynamic>> listaCsv,
    required ParametersReturnResult parameters,
  }) async {
    final ressaProcessada = await ProcessarCsvUsecase(
      datasource: ProcessarCsvEmOpsDatasource(),
    )(
        parameters: ParametrosProcessarCsvEmRemessa(
      listaBruta: listaCsv,
      nameFeature: parameters.nameFeature,
      showRuntimeMilliseconds: parameters.showRuntimeMilliseconds,
      error: parameters.error,
    ));
    return ressaProcessada;
  }
}
