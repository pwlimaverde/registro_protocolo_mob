import 'package:dependencies_module/dependencies_module.dart';
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
        carregarCsvPresenter: CarregarCsvPresenter(),
      );
    });
  }
}
