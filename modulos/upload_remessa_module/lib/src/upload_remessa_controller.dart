import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

import 'features/mapeamento_dados_arquivo_html/domain/usecase/mapeamento_dados_arquivo_html_usecase.dart';
import 'features/processamento_dados_arquivo_html/domain/usecase/processamento_dados_arquivo_html_usecase.dart';
import 'features/upload_remessa_firebase/domain/usecase/upload_remessa_firebase_usecase.dart';
import 'utils/errors/erros_upload_remessa.dart';
import 'utils/parametros/parametros_upload_remessa_module.dart';

class UploadRemessaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final UploadArquivoHtmlPresenter uploadArquivoHtmlPresenter;
  final MapeamentoDadosArquivoHtmlUsecase mapeamentoDadosArquivoHtmlUsecase;
  final ProcessamentoDadosArquivoHtmlUsecase
      processamentoDadosArquivoHtmlUsecase;
  final UploadRemessaFirebaseUsecase uploadRemessaFirebaseUsecase;
  UploadRemessaController({
    required this.uploadArquivoHtmlPresenter,
    required this.mapeamentoDadosArquivoHtmlUsecase,
    required this.processamentoDadosArquivoHtmlUsecase,
    required this.uploadRemessaFirebaseUsecase,
  });

  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Remessas Novas"),
    const Tab(text: "Remessas Duplicdas"),
    const Tab(text: "Remessas com erro"),
  ];

  final List<Tab> myTabsSmall = <Tab>[
    const Tab(text: "Novas"),
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

  final uploadRemessaList = <RemessaModel>[].obs;
  final duplicadasRemessaList = <RemessaModel>[].obs;
  final uploadRemessaListError = <RemessaModel>[].obs;

  void _clearLists() {
    uploadRemessaList.clear();
    duplicadasRemessaList.clear();
    uploadRemessaListError.clear();
  }

  Future<void> setUploadOps() async {
    _clearLists();
    final processamento = await _processamentoDados(
      listaMapBruta: await _mapeamentoDadosArquivo(
        listaMapBytes: await _carregarArquivos(),
      ),
    );
    final uploadFirebase = await uploadRemessaFirebaseUsecase(
      parameters: ParametrosUploadRemessa(
          listaRemessaCarregados: processamento,
          error: ErroUploadArquivo(
              message:
                  "Erro ao fazer o upload da Remessa para o banco de dados"),
          showRuntimeMilliseconds: true,
          nameFeature: "upload firebase"),
    );
    print(uploadFirebase.status);
    print(uploadFirebase.result);
  }

  Future<List<Map<String, Uint8List>>> _carregarArquivos() async {
    final arquivos = await uploadArquivoHtmlPresenter(
      parameters: NoParams(
        error: ErroUploadArquivo(
          message: "Erro ao fazer o upload do arquivo.",
        ),
        showRuntimeMilliseconds: true,
        nameFeature: "Carregamento de Arquivo",
      ),
    );
    if (arquivos.status == StatusResult.success) {
      return arquivos.result;
    } else {
      coreModuleController.message(
        MessageModel.error(
          title: 'Carregamento de arquivos',
          message: 'Erro ao carregar os arquivos - ${arquivos.result}',
        ),
      );
      throw Exception("Erro ao carregar os arquivos - ${arquivos.result}");
    }
  }

  Future<List<Map<String, Map<String, dynamic>>>> _mapeamentoDadosArquivo(
      {required List<Map<String, Uint8List>> listaMapBytes}) async {
    final mapeamento = await mapeamentoDadosArquivoHtmlUsecase(
      parameters: ParametrosMapeamentoArquivoHtml(
        error: ErroUploadArquivo(
          message: "Erro ao fazer o mapeamento do arquivo.",
        ),
        nameFeature: 'Mapeamento Arquivo',
        showRuntimeMilliseconds: true,
        listaMapBytes: listaMapBytes,
      ),
    );
    if (mapeamento.status == StatusResult.success) {
      return mapeamento.result;
    } else {
      coreModuleController.message(
        MessageModel.error(
          title: 'Mapeamento de arquivos',
          message: 'Erro ao mapear os arquivos - ${mapeamento.result}',
        ),
      );
      throw Exception("Erro ao mapear os arquivos - ${mapeamento.result}");
    }
  }

  Future<List<RemessaModel>> _processamentoDados({
    required List<Map<String, Map<String, dynamic>>> listaMapBruta,
  }) async {
    final remessasProcessadas = await processamentoDadosArquivoHtmlUsecase(
      parameters: ParametrosProcessamentoArquivoHtml(
        error: ErroUploadArquivo(
          message: "Erro ao processar Arquivo",
        ),
        nameFeature: 'Processamento Arquivo',
        listaMapBruta: listaMapBruta,
        showRuntimeMilliseconds: true,
      ),
    );

    if (remessasProcessadas.status == StatusResult.success) {
      final listRemessa = remessasProcessadas.result["remessasProcessadas"];
      final listRemessaError =
          remessasProcessadas.result["remessasProcessadasError"];
      coreModuleController.message(
        MessageModel.info(
          title: "Processamento de OPS",
          message:
              "${listRemessa.length} Processadas com Sucesso! \n ${listRemessaError.length} Processadas com Erro!",
        ),
      );
      if (listRemessaError.isNotEmpty) {
        uploadRemessaListError(listRemessaError);
      }
      if (listRemessa.isNotEmpty) {
        return listRemessa;
      } else {
        coreModuleController.message(
          MessageModel.error(
            title: 'Processamento de OPS',
            message: 'Erro! nenhuma OP a ser processada!',
          ),
        );
        return <RemessaModel>[];
      }
    } else {
      coreModuleController.message(
        MessageModel.error(
          title: 'Processamento de OPS',
          message: 'Erro ao processar as OPS!',
        ),
      );
      return <RemessaModel>[];
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
  // }

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
}
