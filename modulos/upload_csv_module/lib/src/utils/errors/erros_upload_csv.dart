import 'package:dependencies_module/dependencies_module.dart';

class ErroUploadCsv implements AppError {
  @override
  String message;
  ErroUploadCsv({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadCsv - $message";
  }
}

class ErroProcessamentoCsv implements AppError {
  @override
  String message;
  ErroProcessamentoCsv({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadCsv - $message";
  }
}

class ErroUploadBoleto implements AppError {
  @override
  String message;
  ErroUploadBoleto({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadBoleto - $message";
  }
}

class ErroUploadArquivo implements AppError {
  @override
  String message;
  ErroUploadArquivo({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadCsv - $message";
  }
}
