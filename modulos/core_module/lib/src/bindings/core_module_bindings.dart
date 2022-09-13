import 'package:dependencies_module/dependencies_module.dart';

class CoreModuleBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<CoreModuleController>(
      CoreModuleController(),
      permanent: true,
    );
    // Get.put<DesignSystemController>(
    //   DesignSystemController(),
    //   permanent: true,
    // );
  }
}
