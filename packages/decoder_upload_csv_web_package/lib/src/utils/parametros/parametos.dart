import 'package:dependencies_module/dependencies_module.dart';

class ParametrosProcessarCsvEmRemessa implements ParametersReturnResult {
  final List<List<dynamic>> listaBruta;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosProcessarCsvEmRemessa({
    required this.listaBruta,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
