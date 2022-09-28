import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

import 'features/mapeamento_dados_arquivo_html/domain/usecase/mapeamento_dados_arquivo_html_usecase.dart';
import 'features/processamento_dados_arquivo_html/domain/usecase/processamento_dados_arquivo_html_usecase.dart';
import 'features/upload_ops/domain/usecase/upload_boleto_usecase.dart';
import 'utils/errors/erros_upload_remessa.dart';
import 'utils/parametros/parametros_upload_remessa_module.dart';

class UploadRemessaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final UploadBoletoUsecase uploadOpsUsecase;
  final MapeamentoDadosArquivoHtmlUsecase mapeamentoDadosArquivoHtmlUsecase;
  final ProcessamentoDadosArquivoHtmlUsecase
      processamentoDadosArquivoHtmlUsecase;
  final UploadArquivoHtmlPresenter uploadArquivoHtmlPresenter;
  UploadRemessaController({
    required this.uploadOpsUsecase,
    required this.mapeamentoDadosArquivoHtmlUsecase,
    required this.uploadArquivoHtmlPresenter,
    required this.processamentoDadosArquivoHtmlUsecase,
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

  final uploadRemessaOpsList = <BoletoModel>[].obs;
  final updateCsvOpsList = <BoletoModel>[].obs;
  final duplicadasCsvOpsList = <BoletoModel>[].obs;
  final uploadRemessaOpsListError = <BoletoModel>[].obs;

  void _clearLists() {
    uploadRemessaOpsList.clear();
    updateCsvOpsList.clear();
    duplicadasCsvOpsList.clear();
    uploadRemessaOpsListError.clear();
  }

  Future<void> setUploadOps() async {
    _clearLists();
    final arquivos = await uploadArquivoHtmlPresenter(
      parameters: NoParams(
          error:
              ErroUploadArquivo(message: "Erro ao fazer o upload do arquivo."),
          showRuntimeMilliseconds: true,
          nameFeature: "Carregamento de Arquivo"),
    );
    final teste = await mapeamentoDadosArquivoHtmlUsecase(
      parameters: ParametrosMapeamentoArquivoHtml(
        error: ErroUploadArquivo(message: "Erro ao fazer o upload do arquivo."),
        nameFeature: 'Upload Arquivo Html',
        showRuntimeMilliseconds: true,
        listaMapBytes: arquivos.result,
      ),
    );

    if (teste.status == StatusResult.success) {
      final testeProcessamento = await processamentoDadosArquivoHtmlUsecase(
        parameters: ParametrosProcessamentoArquivoHtml(
          error: ErroProcessamentoCsv(message: "Erro ao processar Arquivo"),
          nameFeature: 'Teste Processamento',
          listaMapBruta: teste.result,
          showRuntimeMilliseconds: true,
        ),
      );
      print(testeProcessamento.status);

      print(testeProcessamento.result);
    }
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
  //     uploadRemessaOpsListError(listOpsError);
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
  //       uploadRemessaOpsList(listOpsNovas);
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
}
