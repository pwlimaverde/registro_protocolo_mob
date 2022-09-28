import 'package:dependencies_module/dependencies_module.dart';

class UploadBoletoUsecase
    extends UseCaseImplement<Map<String, List<BoletoModel>>> {
  final Datasource<Map<String, List<BoletoModel>>> datasource;

  UploadBoletoUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<Map<String, List<BoletoModel>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
