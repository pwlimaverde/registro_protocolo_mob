import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

import 'features/upload_ops/domain/usecase/upload_boleto_usecase.dart';
import 'utils/errors/erros_upload_csv.dart';

class UploadCsvController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CarregarCsvUsecase carregarCsvUsecase;
  final ProcessarCsvUsecase processarCsvUsecase;
  final UploadBoletoUsecase uploadOpsUsecase;
  UploadCsvController({
    required this.carregarCsvUsecase,
    required this.processarCsvUsecase,
    required this.uploadOpsUsecase,
  });

  final List<Tab> myTabs = <Tab>[
    const Tab(text: "OPs Novas"),
    const Tab(text: "Ops Atualizadas"),
    const Tab(text: "Ops Duplicdas"),
    const Tab(text: "Ops com erro"),
  ];

  final List<Tab> myTabsSmall = <Tab>[
    const Tab(text: "Novas"),
    const Tab(text: "Atual."),
    const Tab(text: "Dupli."),
    const Tab(text: "Erro"),
  ];

  late TabController _tabController;

  TabController get tabController => _tabController;

  @override
  void onInit() async {
    super.onInit();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onReady() {
    super.onReady();
    setUploadOps();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    _clearLists();
    return super.onDelete;
  }

  final uploadCsvOpsList = <BoletoModel>[].obs;
  final updateCsvOpsList = <BoletoModel>[].obs;
  final duplicadasCsvOpsList = <BoletoModel>[].obs;
  final uploadCsvOpsListError = <BoletoModel>[].obs;

  void _clearLists() {
    uploadCsvOpsList.clear();
    updateCsvOpsList.clear();
    duplicadasCsvOpsList.clear();
    uploadCsvOpsListError.clear();
  }

  Future<void> setUploadOps() async {
    _clearLists();
    await _processarRemessa(listaCsv: await _carregarCsv());
  }

  Future<List<List<dynamic>>?> _carregarCsv() async {
    final stringList = await carregarCsvUsecase(
      parameters: NoParams(
        error: ErroUploadCsv(
          message: 'Erro ao carregar o arquivo CSV',
        ),
        showRuntimeMilliseconds: false,
        nameFeature: "Upload Csv",
      ),
    );

    if (stringList.status == StatusResult.success) {
      return stringList.result;
    } else {
      coreModuleController.message(
        MessageModel.error(
          title: 'Carregamento de arquivo CVS',
          message: 'Erro ao carregar o arquivo - ${stringList.result})}',
        ),
      );
      return null;
    }
  }

  Future<RemessaModel?> _processarRemessa({
    required List<List<dynamic>>? listaCsv,
  }) async {
    final ressaProcessada = listaCsv != null
        ? await processarCsvUsecase(
            parameters: ParametrosProcessarCsvEmRemessa(
              listaBruta: listaCsv,
              nameFeature: "Processamento Csv",
              showRuntimeMilliseconds: true,
              error: ErroProcessamentoCsv(
                message: 'Erro ao processar o arquivo CSV',
              ),
            ),
          )
        : null;

    if (ressaProcessada != null &&
        ressaProcessada.status == StatusResult.success) {
      print("========");
      print(ressaProcessada.result);
      print("========");
      return ressaProcessada.result;
    } else {
      return null;
    }
    // if (opsProcessadas is SuccessReturn<Map<String, List<OpsModel>>>) {
    //   final listOps = opsProcessadas.result["listOps"] ?? [];
    //   final listOpsError = opsProcessadas.result["listOpsError"] ?? [];
    //   coreModuleController.message(
    //     MessageModel.info(
    //       title: "Processamento de OPS",
    //       message:
    //           "${listOps.length} Processadas com Sucesso! \n ${listOpsError.length} Processadas com Erro!",
    //     ),
    //   );
    //   if (listOpsError.isNotEmpty) {
    //     uploadCsvOpsListError(listOpsError);
    //   }
    //   if (listOps.isNotEmpty) {
    //     return listOps;
    //   } else {
    //     coreModuleController.message(
    //       MessageModel.error(
    //         title: 'Processamento de OPS',
    //         message: 'Erro! nenhuma OP a ser processada!',
    //       ),
    //     );
    //     return null;
    //   }
    // } else {
    //   coreModuleController.message(
    //     MessageModel.error(
    //       title: 'Processamento de OPS',
    //       message: 'Erro ao processar as OPS!',
    //     ),
    //   );
    //   return null;
  }
}

  // Future<Map<String, List<OpsModel>>?> _triagemOps({
  //   required List<OpsModel>? listaOps,
  // }) async {
  //   final uploadOps = listaOps != null
  //       ? await uploadOpsUsecase(
  //           parameters: ParametrosUploadOps(
  //             error: ErroUploadOps(message: "Erro ao fazer o upload das Ops!"),
  //             listaOpsCarregadas: listaOps,
  //             nameFeature: 'Uploadv Ops',
  //             showRuntimeMilliseconds: false,
  //           ),
  //         )
  //       : null;

  //   if (uploadOps is SuccessReturn<Map<String, List<OpsModel>>>) {
  //     return uploadOps.result;
  //   } else {
  //     coreModuleController.message(
  //       MessageModel.error(
  //         title: 'Triagem OPS',
  //         message: 'Erro ao fazer a triagem das OPS!',
  //       ),
  //     );
  //     return null;
  //   }


  // Future<void> _uploadOps({
  //   required Map<String, List<OpsModel>>? triagemOps,
  // }) async {
  //   if (triagemOps != null) {
  //     final listOpsNovas = triagemOps["listOpsNovas"] ?? [];
  //     final listOpsUpdate = triagemOps["listOpsUpdate"] ?? [];
  //     final listOpsDuplicadas = triagemOps["listOpsDuplicadas"] ?? [];
  //     if (listOpsNovas.isNotEmpty) {
  //       final Iterable<Future<OpsModel>> enviarOpsFuturo =
  //           listOpsNovas.map(_enviarNovaOp);

  //       final Future<Iterable<OpsModel>> waited = Future.wait(enviarOpsFuturo);

  //       await waited;
  //       coreModuleController.message(
  //         MessageModel.info(
  //           title: "Upload de OPS",
  //           message: "Upload de ${listOpsNovas.length} Ops com Sucesso!",
  //         ),
  //       );
  //       uploadCsvOpsList(listOpsNovas);
  //     }
  //     if (listOpsUpdate.isNotEmpty) {
  //       final Iterable<Future<OpsModel>> enviarOpsFuturo =
  //           listOpsUpdate.map(_enviarUpdateOp);

  //       final Future<Iterable<OpsModel>> waited = Future.wait(enviarOpsFuturo);

  //       await waited;
  //       coreModuleController.message(
  //         MessageModel.info(
  //           title: "Upload de OPS",
  //           message: "Update de ${listOpsUpdate.length} Ops com Sucesso!",
  //         ),
  //       );
  //       updateCsvOpsList(listOpsUpdate);
  //     }
  //     if (listOpsDuplicadas.isNotEmpty) {
  //       coreModuleController.message(
  //         MessageModel.info(
  //           title: "Upload de OPS",
  //           message: "${listOpsDuplicadas.length} Ops duplicadas!",
  //         ),
  //       );
  //       duplicadasCsvOpsList(listOpsDuplicadas);
  //     }
  //     _tabController.index = listOpsNovas.isNotEmpty
  //         ? 0
  //         : listOpsUpdate.isNotEmpty
  //             ? 1
  //             : 2;
  //   }
  // }

  // Future<OpsModel> _enviarNovaOp(OpsModel model) async {
  //   await opsController.mutationInsertOps(
  //     parametros: ParametrosOpsMutation(
  //       error: ErroUploadOps(message: "Erro ao enviar nova OP!"),
  //       messageError: MessageModel.error(
  //         title: 'Erro ao enviar nova OP!',
  //         message:
  //             'Não foi possível registrar a OP ${model.op} no banco de dados!',
  //       ),
  //       messageInfo: null,
  //       mutation: uploadOpsMutation,
  //       nameFeature: "Upload de novas Ops",
  //       showRuntimeMilliseconds: false,
  //       variables: {
  //         "orcamento": model.orcamento,
  //         "cliente": model.cliente,
  //         "servico": model.servico,
  //         "quant": model.quant,
  //         "entrada": designSystemController.df.format(model.entrada),
  //         "entrega": designSystemController.df.format(model.entrega),
  //         "vendedor": model.vendedor,
  //         "op": model.op,
  //       },
  //     ),
  //   );
  //   return model;
  // }

  // Future<OpsModel> _enviarUpdateOp(OpsModel model) async {
  //   await opsController.mutationUpdateOps(
  //     parametros: ParametrosOpsMutation(
  //       error: ErroUploadOps(message: "Erro ao atualizar OP!"),
  //       messageError: MessageModel.error(
  //         title: 'Erro ao atualizar OP!',
  //         message:
  //             'Não foi possível atualizar a OP ${model.op} no banco de dados!',
  //       ),
  //       messageInfo: null,
  //       mutation: opsUpdateMutation,
  //       nameFeature: "Update Ops",
  //       showRuntimeMilliseconds: false,
  //       variables: {
  //         "op": model.op,
  //         "servico": model.servico,
  //         "cliente": model.cliente,
  //         "quant": model.quant,
  //         "vendedor": model.vendedor,
  //         "entrega": designSystemController.df.format(model.entrega),
  //       },
  //     ),
  //   );
  //   return model;
  // }
// }
