import 'package:dependencies_module/dependencies_module.dart';

class ProcessarCsvEmOpsDatasource implements Datasource<RemessaModel> {
  @override
  Future<RemessaModel> call(
      {required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosProcessarCsvEmRemessa) {
        final remessa = RemessaModel(
          nomeArquivo: parameters.listaBruta[0][0],
          data: parameters.listaBruta[1].last,
          remessa: await _processamentoBoleto(
            listaBruta: parameters.listaBruta,
          ),
        );

        return remessa;
      } else {
        throw Exception("Erro ao processar arquivo");
      }
    } catch (e) {
      throw Exception("Erro ao processar arquivo");
    }
  }
}

Future<List<BoletoModel>> _processamentoBoleto({
  required List<List<dynamic>> listaBruta,
}) async {
  List<BoletoModel> boletos = [];
  List<List<dynamic>> listaDados = [];
  List<dynamic> cabecario = listaBruta[2];
  listaDados.addAll(listaBruta);

  listaDados.removeRange(0, 3);

  if (listaDados.isNotEmpty) {
    for (List<dynamic> lista in listaDados) {
      Map<String, String> modelJason = {};
      for (dynamic item in lista) {
        int indexL = lista.indexOf(item);
        modelJason.addAll({"${cabecario[indexL]}": "$item"});
      }
      final keyteste = modelJason.keys.first;
      final valueteste = int.tryParse(modelJason['ID Cliente'].toString());
      if (keyteste == 'ID Cliente' && valueteste != null && valueteste > 0) {
        BoletoModel model = BoletoModel.fromMap(modelJason);
        boletos.add(model);
      }
    }
    return boletos;
  } else {
    throw Exception("Erro ao processar arquivo");
  }
}
// try {
//   if (parameters is ParametrosProcessarCsvEmOps) {
//     List<BoletoModel> listBoletos = [];
//     List<BoletoModel> listBoletosError = [];

//     for (String item in parameters.listaBruta) {
//       List<String> listaProcessamentoInicial =
//           _processamentoCsv(listaBruta: item);

// if (listaProcessamentoInicial.isNotEmpty) {
//   DateTime? entrada = _processamentoCsvEntrada(
//     listaProcessamentoInicial: listaProcessamentoInicial,
//   );
//   DateTime? entrega = _processamentoCsvEntrega(
//     listaProcessamentoInicial: listaProcessamentoInicial,
//     entrada: entrada,
//   );
// int? idCliente = _processamentoIdCliente(
//     listaProcessamentoInicial: listaProcessamentoInicial);
//   );
//   int? orcamento = _processamentoCsvOrcamento(
//     listaProcessamentoInicial: listaProcessamentoInicial,
//   );
//   int? quantidade = _processamentoCsvQuantidade(
//     listaProcessamentoInicial: listaProcessamentoInicial,
//   );
//   String? servico = _processamentoCsvServico(
//     listaProcessamentoInicial: listaProcessamentoInicial,
//   );
//   String? cliente = _processamentoCsvCliente(
//     listaProcessamentoInicial: listaProcessamentoInicial,
//   );
//   String? vendedor = _processamentoCsvVendedor(
//     listaProcessamentoInicial: listaProcessamentoInicial,
//   );

// if (entrada != null &&
//     entrega != null &&
//     op != null &&
//     orcamento != null &&
//     quantidade != null &&
//     servico != null &&
//     cliente != null &&
//     vendedor != null) {
//   OpsModel up = OpsModel(
//     entrada: entrada,
//     entrega: entrega,
//     op: op,
//     orcamento: orcamento,
//     quant: quantidade,
//     servico: servico,
//     cliente: cliente,
//     vendedor: vendedor,
//   );
//   listOps.add(up);
// } else {
//   OpsModel upError = OpsModel(
//     entrada: entrada ?? designSystemController.now,
//     entrega: entrega ?? designSystemController.now,
//     op: op ?? 0,
//     orcamento: orcamento ?? 0,
//     quant: quantidade ?? 0,
//     servico: servico ?? "erro serviço",
//     cliente: cliente ?? "erro cliente",
//     vendedor: vendedor ?? "erro vendedor",
//   );
//   upError.obs =
//       " Falha no processamento em um ou mais campos! A OP não será salva no banco de dados!";
//   listOpsError.add(upError);
// }
//   }
// }

// return Future.value({
//   "listOps": listOps.toSet().toList(),
//   "listOpsError": listOpsError.toSet().toList()
// });
//     } else {
//       throw Exception("Erro ao processar arquivo");
//     }
//   } catch (e) {
//     throw Exception("Erro ao processar arquivo");
//   }
// }

// String _convertMes(String mes) {
//   switch (mes) {
//     case "jan":
//       return "01";
//     case "fev":
//       return "02";
//     case "mar":
//       return "03";
//     case "abr":
//       return "04";
//     case "mai":
//       return "05";
//     case "jun":
//       return "06";
//     case "jul":
//       return "07";
//     case "ago":
//       return "08";
//     case "set":
//       return "09";
//     case "out":
//       return "10";
//     case "nov":
//       return "11";
//     default:
//       return "12";
//   }
// }

// List<String> _processamentoCsv({required String listaBruta}) {
//   try {
//     List<String> listaProcessamentoInicial = listaBruta
//         // .replaceAll("\r\n", " | ")
//         // .trim()
//         // .replaceAll('${designSystemController.ano},',
//         //     '${designSystemController.ano}","')
//         // .replaceAll('${int.parse(designSystemController.ano) - 1},',
//         //     '${int.parse(designSystemController.ano) - 1}","')
//         // .replaceAll(',","', '","')
//         // .replaceFirst(',', ',"')
//         .trim()
//         .split(',');
//     return listaProcessamentoInicial;
//   } catch (e) {
//     return [];
//   }
// }

// DateTime? _processamentoCsvEntrada({
//   required List<String> listaProcessamentoInicial,
// }) {
//   try {
//     String entradaBruta = listaProcessamentoInicial[4]
//         .substring(listaProcessamentoInicial[4].indexOf('",') + 2)
//         .replaceAll('"', '')
//         .trim();
//     DateTime? entradaProcessada = DateTime.parse(
//       "${entradaBruta.substring(6, 10)}-${entradaBruta.substring(3, 5)}-${entradaBruta.substring(0, 2)}",
//     );
//     int dif = int.parse(
//       designSystemController.now
//           .difference(entradaProcessada)
//           .inDays
//           .toString(),
//     );
//     if (dif < 60) {
//       return entradaProcessada;
//     } else {
//       null;
//     }
//   } catch (e) {
//     return null;
//   }
// }

// int? _processamentoIdCliente({
//   required List<String> listaProcessamentoInicial,
// }) {
//   return 1;
// try {
//   String voe = listaProcessamentoInicial[5];
//   String oe = voe.substring(voe.indexOf(',') + 1);
//   int? op = int.parse(oe.substring(0, oe.indexOf(',')));
//   return op;
// } catch (e) {
//   return null;
// }
// }

// int? _processamentoCsvOrcamento({
//   required List<String> listaProcessamentoInicial,
// }) {
//   try {
//     int? orcamento = int.parse(listaProcessamentoInicial[0]
//         .replaceAll("|", " ")
//         .trim()
//         .substring(0, 5));
//     return orcamento;
//   } catch (e) {
//     return null;
//   }
// }

// int? _processamentoCsvQuantidade({
//   required List<String> listaProcessamentoInicial,
// }) {
//   try {
//     int? quantidade = int.parse(listaProcessamentoInicial[3]
//         .replaceAll('"', '')
//         .replaceAll(',00', '')
//         .replaceAll('.', '')
//         .trim());
//     return quantidade;
//   } catch (e) {
//     return null;
//   }
// }

// String? _processamentoCsvServico({
//   required List<String> listaProcessamentoInicial,
// }) {
//   try {
//     String? servico = listaProcessamentoInicial[2].replaceAll('"', '').trim();
//     return servico;
//   } catch (e) {
//     return null;
//   }
// }

// String? _processamentoCsvCliente({
//   required List<String> listaProcessamentoInicial,
// }) {
//   try {
//     String? cliente = listaProcessamentoInicial[1].replaceAll('"', '').trim();
//     return cliente;
//   } catch (e) {
//     return null;
//   }
// }

// String? _processamentoCsvVendedor({
//   required List<String> listaProcessamentoInicial,
// }) {
//   try {
//     String voe = listaProcessamentoInicial[5];
//     String vendedor =
//         voe.substring(0, voe.indexOf(',')).replaceAll('"', '').trim();
//     return vendedor;
//   } catch (e) {
//     return null;
//   }
// }

// DateTime? _processamentoCsvEntrega({
//   required List<String> listaProcessamentoInicial,
//   required DateTime? entrada,
// }) {
//   try {
//     if (entrada != null) {
//       String voe = listaProcessamentoInicial[5];
//       String oe = voe.substring(voe.indexOf(',') + 1);

//       String entregaBruta =
//           "${oe.substring(oe.indexOf(',') + 1).substring(0, 6)}-${entrada.year}";

//       DateTime entregaProcessada = DateTime.parse(
//         "${entregaBruta.substring(7, 11)}-${_convertMes(entregaBruta.substring(3, 6))}-${entregaBruta.substring(0, 2)}",
//       );

//       if (entrada.month > entregaProcessada.month) {
//         entregaProcessada = DateTime.parse(
//           "${(entrada.year + 1).toString()}-${_convertMes(entregaBruta.substring(3, 6))}-${entregaBruta.substring(0, 2)}",
//         );
//       }

//       return entregaProcessada;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     return null;
//   }
// }
// }
