import 'package:dependencies_module/dependencies_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

class ParametrosProcessarRemessa implements ParametersReturnResult {
  final List<List<dynamic>> listaBruta;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosProcessarRemessa({
    required this.listaBruta,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}

// class ParametrosCarregarArquivoHtml implements ParametersReturnResult {
//   final List<html.File> listaArquivosHtml;
//   @override
//   final AppError error;
//   @override
//   final bool showRuntimeMilliseconds;
//   @override
//   final String nameFeature;

//   ParametrosCarregarArquivoHtml({
//     required this.listaArquivosHtml,
//     required this.error,
//     required this.showRuntimeMilliseconds,
//     required this.nameFeature,
//   });
// }

class ParametrosLeituraArquivoHtml implements ParametersReturnResult {
  final List<html.File> listaArquivosHtml;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosLeituraArquivoHtml({
    required this.listaArquivosHtml,
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
