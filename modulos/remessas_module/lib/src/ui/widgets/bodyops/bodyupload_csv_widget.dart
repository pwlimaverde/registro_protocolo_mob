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
            // if (remessasController.uploadRemessaOpsList.isNotEmpty ||
            //     remessasController.updateCsvOpsList.isNotEmpty ||
            //     remessasController.duplicadasCsvOpsList.isNotEmpty ||
            //     remessasController.uploadRemessaOpsListError.isNotEmpty) {
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
    color: Colors.red[200],
    child: TabBar(
      controller: remessasController.tabController,
      labelColor: Colors.white,
      indicatorColor: Colors.grey[800],
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      tabs: coreModuleController.showMenu
          ? remessasController.myTabsSmall
          : remessasController.myTabs,
    ),
  );
}

_tabBarView() {
  return SizedBox(
    width: coreModuleController.sizeW,
    height: coreModuleController.sizeH - tabHeight,
    child: TabBarView(
      controller: remessasController.tabController,
      children: [
        // Center(),
        _todasRemessasList()
      ],
    ),
  );
}

_todasRemessasList() {
  final filtro = remessasController.listTadasRemessas;

  return Obx(
    () => Center(
      child: ListView.builder(
        itemCount: filtro.length,
        itemBuilder: (context, index) {
          final remessaModel = filtro[index];
          double size = coreModuleController.size;
          String nomeRemessa = remessaModel.nomeArquivo.length >= 100
              ? remessaModel.nomeArquivo.substring(0, 100)
              : remessaModel.nomeArquivo;
          return Card(
            elevation: 0.5,
            child: SizedBox(
              width: size,
              height: 60,
              child: ListTile(
                title: Text(nomeRemessa),
                subtitle: Text(
                    "Data da Remessa: ${dataFormatoDDMMYYYY.format(remessaModel.data)}"),
                trailing: Column(
                  children: [
                    Text(
                        "Data de Upload: ${dataFormatoDDMMYYYY.format(remessaModel.upload)}"),
                    Text(
                        "Quantidade de Protocolos: ${remessaModel.quantidadeProtocolos.toString()}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
  // return designSystemController.opslistWidget(
  //   filtro: remessasController.uploadRemessaOpsList,
  //   can: opsController.setCancelarOP,
  //   check: opsController.setCheckOP,
  //   save: opsController.setInfoOP,
  //   prioridade: opsController.setPrioridadeOP,
  //   up: true,
  // );
}

// _updateOpsList() {
//   return designSystemController.opslistWidget(
//     filtro: remessasController.updateCsvOpsList,
//     can: opsController.setCancelarOP,
//     check: opsController.setCheckOP,
//     save: opsController.setInfoOP,
//     prioridade: opsController.setPrioridadeOP,
//     up: true,
//   );
// }

// _duplicadasOpsList() {
//   return designSystemController.opslistWidget(
//     filtro: remessasController.duplicadasCsvOpsList,
//     can: opsController.setCancelarOP,
//     check: opsController.setCheckOP,
//     save: opsController.setInfoOP,
//     prioridade: opsController.setPrioridadeOP,
//     up: true,
//   );
// }

// _uploadOpsListError() {
//   return designSystemController.opslistWidget(
//     filtro: remessasController.uploadRemessaOpsListError,
//     can: opsController.setCancelarOP,
//     check: opsController.setCheckOP,
//     save: opsController.setInfoOP,
//     prioridade: opsController.setPrioridadeOP,
//     up: true,
//   );
// }
