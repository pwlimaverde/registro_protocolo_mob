import 'package:dependencies_module/dependencies_module.dart';

class ParametrosUploadBoleto implements ParametersReturnResult {
  final List<BoletoModel> listaBoletosCarregados;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosUploadBoleto({
    required this.listaBoletosCarregados,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
