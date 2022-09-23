import 'package:dependencies_module/dependencies_module.dart';

class ProcessarXlsxUsecase extends UseCaseImplement<RemessaModel> {
  final Datasource<RemessaModel> datasource;

  ProcessarXlsxUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<RemessaModel>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
