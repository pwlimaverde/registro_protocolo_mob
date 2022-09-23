import 'package:dependencies_module/dependencies_module.dart';

class CarregarXlsxUsecase extends UseCaseImplement<List<List<dynamic>>> {
  final Datasource<List<List<dynamic>>> datasource;

  CarregarXlsxUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<List<dynamic>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
