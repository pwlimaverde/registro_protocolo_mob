import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

class WidgetsFlutterBindingService extends GetxService {
  WidgetsBinding init() {
    final widgetsFlutterBinding = WidgetsFlutterBinding.ensureInitialized();
    return widgetsFlutterBinding;
  }
}
