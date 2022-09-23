import 'package:dependencies_module/dependencies_module.dart';
import '../features/carregar_arquivo_html/datasources/upload_arquivo_html_datasource.dart';
import '../features/carregar_arquivo_html/domain/usecase/carregar_arquivo_html_usecase.dart';
import '../features/mapeamento_dados_arquivo_html/datasources/mapeamento_dados_arquivo_html_datasource.dart';
import '../features/mapeamento_dados_arquivo_html/domain/usecase/mapeamento_dados_arquivo_html_usecase.dart';
import '../utils/parametros/parametos.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class CarregarArquivoPresenter implements Presenter {
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

  Future<List<html.File>> _carregarCsv(
      {required ParametersReturnResult parameters}) async {
    final stringList = await CarregarArquivoHtmlUsecase(
      datasource: UploadArquivoHtmlDatasource(),
    )(
      parameters: parameters,
    );

    if (stringList.status == StatusResult.success) {
      return stringList.result;
    } else {
      throw Exception("Erro ao carregar arquivo");
    }
  }

  Future<ReturnSuccessOrError<List<Map<String, dynamic>>>> _processarRemessa({
    required List<html.File> listaCsv,
    required ParametersReturnResult parameters,
  }) async {
    final ressaProcessada = await MapeamentoDadosArquivoHtmlUsecase(
      datasource: MapeamentoDadosArquivoHtmlDatasource(),
    )(
        parameters: ParametrosListarDadosRemessa(
      listaBruta: listaCsv,
      nameFeature: parameters.nameFeature,
      showRuntimeMilliseconds: parameters.showRuntimeMilliseconds,
      error: parameters.error,
    ));
    return ressaProcessada;
  }
}
