import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'service/firebase/firebase_service.dart';
import 'service/storage/storage_service.dart';
import 'service/widgets_flutter_binding/widgets_flutter_binding_service.dart';

void initServices() async {
  if (kDebugMode) {
    print('starting services ...');
  }
  Get.put<GetStorage>(
    StorageService().init(),
    permanent: true,
  );
  Get.put<WidgetsBinding>(
    WidgetsFlutterBindingService().init(),
    permanent: true,
  );
  await Get.putAsync<FirebaseApp>(
    () => FirebaseService().init(),
    permanent: true,
  );
  if (kDebugMode) {
    print('All services started...');
  }
}
