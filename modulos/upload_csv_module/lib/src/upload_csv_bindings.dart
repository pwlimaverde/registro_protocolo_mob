import 'package:dependencies_module/dependencies_module.dart';
import 'features/mapeamento_dados_arquivo_html/datasources/mapeamento_dados_arquivo_html_datasource.dart';
import 'features/mapeamento_dados_arquivo_html/domain/usecase/mapeamento_dados_arquivo_html_usecase.dart';
import 'features/upload_ops/datasources/upload_ops_datasource.dart';
import 'features/upload_ops/domain/usecase/upload_boleto_usecase.dart';

class UploadCsvBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadCsvController>(() {
      return UploadCsvController(
        uploadOpsUsecase: UploadBoletoUsecase(
          datasource: UploadOpsDatasource(),
        ),
        mapeamentoDadosArquivoHtmlUsecase: MapeamentoDadosArquivoHtmlUsecase(
          datasource: MapeamentoDadosArquivoHtmlDatasource(),
        ),
        uploadArquivoHtmlPresenter: UploadArquivoHtmlPresenter(),
      );
    });
  }
}
