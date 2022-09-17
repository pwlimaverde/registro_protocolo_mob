import 'package:dependencies_module/dependencies_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert' as convert;

class UploadCsvHtmlDatasource implements Datasource<List<List<dynamic>>> {
  @override
  Future<List<List<dynamic>>> call(
      {required ParametersReturnResult parameters}) async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.click();

    final testeElement = await uploadInput.onChange.first.then((_) async {
      List<html.File>? files = uploadInput.files;

      if (files != null && files.isNotEmpty) {
        List<List<dynamic>> listaGeral = [];
        for (html.File file in files) {
          listaGeral.addAll(await _listaBruta(file: file));
        }
        return listaGeral;
      } else {
        throw Exception("Erro ao carregar arquivo");
      }
    });
    return testeElement;
  }

  Future<List<List<dynamic>>> _listaBruta({required html.File file}) {
    final reader = html.FileReader();

    final resultReader = reader.onLoadEnd.first.then((_) {
      Object? result = reader.result;
      String s = result.toString();
      String base64 = s.substring(s.indexOf(",") + 1);

      if (!file.name.contains(".csv")) {
        throw Exception("Arquivo carregado não é csv");
      }
      final bytes = convert.base64.decode(base64);
      final decoderByte = convert.latin1.decode(bytes);
      List<List<dynamic>> csv = [];
      csv.add([file.name]);
      csv.addAll(
          const CsvToListConverter(fieldDelimiter: ";").convert(decoderByte));
      return csv;
    });

    reader.readAsDataUrl(file);

    return resultReader;
  }
}
