import 'package:dependencies_module/dependencies_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert' as convert;

class UploadXlsxHtmlDatasource implements Datasource<List<List<dynamic>>> {
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

      if (!file.name.contains(".xlsx")) {
        throw Exception("Arquivo carregado não é xlsx");
      }
      final bytes = convert.base64.decode(base64);
      var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      List<List<dynamic>> xlsx = [];
      xlsx.add([file.name]);
      // for (var table in decoder.tables.keys) {
      //   print(table);
      //   print(decoder.tables[table]!.maxCols);
      //   print(decoder.tables[table]!.maxRows);
      //   for (var row in decoder.tables[table]!.rows) {
      //     print('$row');
      //   }
      // }

      xlsx.addAll(decoder.tables[decoder.tables.keys.first]!.rows);
      // print(xlsx);

      return xlsx;
    });

    reader.readAsDataUrl(file);

    return resultReader;
  }
}
