import 'package:dependencies_module/dependencies_module.dart';

class ErroDecoderUploadCsvWeb implements AppError {
  @override
  String message;
  ErroDecoderUploadCsvWeb({
    required this.message,
  });

  @override
  String toString() {
    return "ErroDecoderUploadCsvWeb - $message";
  }
}
