import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../core_module.dart';

class RemessaModel {
  final String nomeArquivo;
  final DateTime data;
  final List<BoletoModel> remessa;
  final int quantidadeProtocolos;
  RemessaModel({
    required this.nomeArquivo,
    required this.data,
    required this.remessa,
  }) : quantidadeProtocolos = remessa.length;

  RemessaModel copyWith({
    String? nomeArquivo,
    DateTime? data,
    List<BoletoModel>? remessa,
  }) {
    return RemessaModel(
      nomeArquivo: nomeArquivo ?? this.nomeArquivo,
      data: data ?? this.data,
      remessa: remessa ?? this.remessa,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomeArquivo': nomeArquivo,
      'data': data.millisecondsSinceEpoch,
      'remessa': remessa.map((x) => x.toMap()).toList(),
    };
  }

  factory RemessaModel.fromMap(Map<String, dynamic> map) {
    return RemessaModel(
      nomeArquivo: map['nomeArquivo'] ?? '',
      data: DateTime.fromMillisecondsSinceEpoch(map['data']),
      remessa: List<BoletoModel>.from(
          map['remessa']?.map((x) => BoletoModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemessaModel.fromJson(String source) =>
      RemessaModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'RemessaModel(nomeArquivo: $nomeArquivo, data: ${dataFormatoDDMMYYYY.format(data)}, remessa: $remessa, quantidade de protocolos: $quantidadeProtocolos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RemessaModel &&
        other.nomeArquivo == nomeArquivo &&
        other.data == data &&
        listEquals(other.remessa, remessa);
  }

  @override
  int get hashCode => nomeArquivo.hashCode ^ data.hashCode ^ remessa.hashCode;
}
