import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

class BodyUploadRemessaWidget extends StatelessWidget {
  const BodyUploadRemessaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: coreModuleController.sizeH,
      child: Container(
        color: Colors.black12,
        child: Center(
          child: Obx(() {
            // if (uploadRemessaController.uploadRemessaOpsList.isNotEmpty ||
            //     uploadRemessaController.updateCsvOpsList.isNotEmpty ||
            //     uploadRemessaController.duplicadasCsvOpsList.isNotEmpty ||
            //     uploadRemessaController.uploadRemessaOpsListError.isNotEmpty) {
            //   coreModuleController.statusLoad(false);
            // } else {
            //   coreModuleController.statusLoad(true);
            // }
            return Column(
              children: <Widget>[
                _tabBar(),
                _tabBarView(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

_tabBar() {
  return Container(
    height: tabHeight,
    color: Colors.grey[700],
    child: TabBar(
      controller: uploadRemessaController.tabController,
      labelColor: Colors.white,
      indicatorColor: Colors.blue,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      tabs: coreModuleController.showMenu
          ? uploadRemessaController.myTabsSmall
          : uploadRemessaController.myTabs,
    ),
  );
}

_tabBarView() {
  return SizedBox(
    width: coreModuleController.sizeW,
    height: coreModuleController.sizeH - tabHeight,
    child: TabBarView(
      controller: uploadRemessaController.tabController,
      children: [
        Center(),
        Center(),
        Center(),
        // _uploadOpsList(),
        // _duplicadasOpsList(),
        // _uploadOpsListError(),
      ],
    ),
  );
}

// _uploadOpsList() {
//   return designSystemController.opslistWidget(
//     filtro: uploadRemessaController.uploadRemessaOpsList,
//     can: opsController.setCancelarOP,
//     check: opsController.setCheckOP,
//     save: opsController.setInfoOP,
//     prioridade: opsController.setPrioridadeOP,
//     up: true,
//   );
// }

// _updateOpsList() {
//   return designSystemController.opslistWidget(
//     filtro: uploadRemessaController.updateCsvOpsList,
//     can: opsController.setCancelarOP,
//     check: opsController.setCheckOP,
//     save: opsController.setInfoOP,
//     prioridade: opsController.setPrioridadeOP,
//     up: true,
//   );
// }

// _duplicadasOpsList() {
//   return designSystemController.opslistWidget(
//     filtro: uploadRemessaController.duplicadasCsvOpsList,
//     can: opsController.setCancelarOP,
//     check: opsController.setCheckOP,
//     save: opsController.setInfoOP,
//     prioridade: opsController.setPrioridadeOP,
//     up: true,
//   );
// }

// _uploadOpsListError() {
//   return designSystemController.opslistWidget(
//     filtro: uploadRemessaController.uploadRemessaOpsListError,
//     can: opsController.setCancelarOP,
//     check: opsController.setCheckOP,
//     save: opsController.setInfoOP,
//     prioridade: opsController.setPrioridadeOP,
//     up: true,
//   );
// }
