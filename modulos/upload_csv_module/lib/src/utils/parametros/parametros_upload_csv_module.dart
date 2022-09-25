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

class ParametrosMapeamentoArquivoHtml implements ParametersReturnResult {
  final List<Map<String, Uint8List>> listaMapBytes;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosMapeamentoArquivoHtml({
    required this.listaMapBytes,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
