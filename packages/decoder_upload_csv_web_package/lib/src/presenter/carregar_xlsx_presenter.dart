import 'package:dependencies_module/dependencies_module.dart';

import '../features/arquivos_Xlsx/carregar_Xlsx/datasources/upload_Xlsx_html_datasource.dart';
import '../features/arquivos_Xlsx/carregar_Xlsx/domain/usecase/carregar_Xlsx_usecase.dart';
import '../features/arquivos_Xlsx/processar_Xlsx/datasources/processar_Xlsx_em_remessa_datasource.dart';
import '../features/arquivos_Xlsx/processar_Xlsx/domain/usecase/processar_Xlsx_usecase.dart';
import '../utils/parametros/parametos.dart';

class CarregarXlsxPresenter implements Presenter {
  @override
  Future<ReturnSuccessOrError> call(
      {required ParametersReturnResult parameters}) async {
    final remessa = await _processarRemessa(
      listaXlsx: await _carregarXlsx(
        parameters: parameters,
      ),
      parameters: parameters,
    );

    return remessa;
  }

  Future<List<List<dynamic>>> _carregarXlsx(
      {required ParametersReturnResult parameters}) async {
    final stringList = await CarregarXlsxUsecase(
      datasource: UploadXlsxHtmlDatasource(),
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
    required List<List<dynamic>> listaXlsx,
    required ParametersReturnResult parameters,
  }) async {
    final remessaProcessada = await ProcessarXlsxUsecase(
      datasource: ProcessarXlsxEmOpsDatasource(),
    )(
        parameters: ParametrosProcessarRemessa(
      listaBruta: listaXlsx,
      nameFeature: parameters.nameFeature,
      showRuntimeMilliseconds: parameters.showRuntimeMilliseconds,
      error: parameters.error,
    ));
    return remessaProcessada;
  }
}
