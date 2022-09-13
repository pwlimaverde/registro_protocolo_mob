import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema Registro de Protocolos MOB',
      initialBinding: CoreModuleBindings(),
      getPages: [
        ...SplashModule().routers,
        // ...HomeModule().routers,
      ],
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}
