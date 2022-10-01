import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_remessa_module.dart';

class UploadRemessaFirebaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosUploadRemessa) {
        for (RemessaModel model in parameters.listaRemessaCarregados) {
          final mapRemessa = model.toMap();
          await FirebaseFirestore.instance
              .collection("remessas")
              .doc(model.nomeArquivo)
              .set(mapRemessa);
          final _firestore = await FirebaseFirestore.instance
              .collection("remessas")
              .doc(model.nomeArquivo)
              .get();
          final remessaFire2 = _firestore.data();
          if (remessaFire2 != null) {
            final remessaFire = RemessaModel.fromMap(remessaFire2);
            print("**********");
            print(remessaFire);
            print("**********");
          }
        }
        return true;
      } else {
        throw false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload das remessas no banco de dados");
    }
  }
}
