import 'dart:convert';

class BoletoModel {
  final int idCliente;
  final String cliente;
  final int documento;
  final String? email;
  final String? telefoneFixo;
  final String? telefoneMovel;
  final int idContrato;
  final String dataHabilitacaoContrato;
  final String numeroDeBoleto;
  final String formaDeCobranca;
  final String dataVencimentoFatura;
  final int valorFatura;
  final String dataEmissaoFatura;
  final String? arquivo;
  final String? dataImpressaoFatura;
  final String uf;
  final String cidade;
  final String bairro;
  final String tipoLogradouro;
  final String logradouro;
  final int numero;
  final int? cep;
  final String? solicitanteDaGeracao;
  final String idFatura;
  final String? referencia;
  BoletoModel({
    required this.idCliente,
    required this.cliente,
    required this.documento,
    this.email,
    this.telefoneFixo,
    this.telefoneMovel,
    required this.idContrato,
    required this.dataHabilitacaoContrato,
    required this.numeroDeBoleto,
    required this.formaDeCobranca,
    required this.dataVencimentoFatura,
    required this.valorFatura,
    required this.dataEmissaoFatura,
    this.arquivo,
    this.dataImpressaoFatura,
    required this.uf,
    required this.cidade,
    required this.bairro,
    required this.tipoLogradouro,
    required this.logradouro,
    required this.numero,
    this.cep,
    this.solicitanteDaGeracao,
    required this.idFatura,
    this.referencia,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCliente': idCliente,
      'cliente': cliente,
      'documento': documento,
      'email': email,
      'telefoneFixo': telefoneFixo,
      'telefoneMovel': telefoneMovel,
      'idContrato': idContrato,
      'dataHabilitacaoContrato': dataHabilitacaoContrato,
      'numeroDeBoleto': numeroDeBoleto,
      'formaDeCobranca': formaDeCobranca,
      'dataVencimentoFatura': dataVencimentoFatura,
      'valorFatura': valorFatura,
      'dataEmissaoFatura': dataEmissaoFatura,
      'arquivo': arquivo,
      'dataImpressaoFatura': dataImpressaoFatura,
      'uf': uf,
      'cidade': cidade,
      'bairro': bairro,
      'tipoLogradouro': tipoLogradouro,
      'logradouro': logradouro,
      'numero': numero,
      'cep': cep,
      'solicitanteDaGeracao': solicitanteDaGeracao,
      'idFatura': idFatura,
      'referencia': referencia,
    };
  }

  factory BoletoModel.fromMap(Map<String, dynamic> map) {
    return BoletoModel(
      idCliente: map['idCliente']?.toInt() ?? 0,
      cliente: map['cliente'] ?? '',
      documento: map['documento']?.toInt() ?? 0,
      email: map['email'],
      telefoneFixo: map['telefoneFixo'],
      telefoneMovel: map['telefoneMovel'],
      idContrato: map['idContrato']?.toInt() ?? 0,
      dataHabilitacaoContrato: map['dataHabilitacaoContrato'] ?? '',
      numeroDeBoleto: map['numeroDeBoleto'] ?? '',
      formaDeCobranca: map['formaDeCobranca'] ?? '',
      dataVencimentoFatura: map['dataVencimentoFatura'] ?? '',
      valorFatura: map['valorFatura']?.toInt() ?? 0,
      dataEmissaoFatura: map['dataEmissaoFatura'] ?? '',
      arquivo: map['arquivo'],
      dataImpressaoFatura: map['dataImpressaoFatura'],
      uf: map['uf'] ?? '',
      cidade: map['cidade'] ?? '',
      bairro: map['bairro'] ?? '',
      tipoLogradouro: map['tipoLogradouro'] ?? '',
      logradouro: map['logradouro'] ?? '',
      numero: map['numero']?.toInt() ?? 0,
      cep: map['cep']?.toInt(),
      solicitanteDaGeracao: map['solicitanteDaGeracao'],
      idFatura: map['idFatura'] ?? '',
      referencia: map['referencia'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BoletoModel.fromJson(String source) =>
      BoletoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BoletoModel(idCliente: $idCliente, cliente: $cliente, documento: $documento, email: $email, telefoneFixo: $telefoneFixo, telefoneMovel: $telefoneMovel, idContrato: $idContrato, dataHabilitacaoContrato: $dataHabilitacaoContrato, numeroDeBoleto: $numeroDeBoleto, formaDeCobranca: $formaDeCobranca, dataVencimentoFatura: $dataVencimentoFatura, valorFatura: $valorFatura, dataEmissaoFatura: $dataEmissaoFatura, arquivo: $arquivo, dataImpressaoFatura: $dataImpressaoFatura, uf: $uf, cidade: $cidade, bairro: $bairro, tipoLogradouro: $tipoLogradouro, logradouro: $logradouro, numero: $numero, cep: $cep, solicitanteDaGeracao: $solicitanteDaGeracao, idFatura: $idFatura, referencia: $referencia)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoletoModel &&
        other.idCliente == idCliente &&
        other.cliente == cliente &&
        other.documento == documento &&
        other.email == email &&
        other.telefoneFixo == telefoneFixo &&
        other.telefoneMovel == telefoneMovel &&
        other.idContrato == idContrato &&
        other.dataHabilitacaoContrato == dataHabilitacaoContrato &&
        other.numeroDeBoleto == numeroDeBoleto &&
        other.formaDeCobranca == formaDeCobranca &&
        other.dataVencimentoFatura == dataVencimentoFatura &&
        other.valorFatura == valorFatura &&
        other.dataEmissaoFatura == dataEmissaoFatura &&
        other.arquivo == arquivo &&
        other.dataImpressaoFatura == dataImpressaoFatura &&
        other.uf == uf &&
        other.cidade == cidade &&
        other.bairro == bairro &&
        other.tipoLogradouro == tipoLogradouro &&
        other.logradouro == logradouro &&
        other.numero == numero &&
        other.cep == cep &&
        other.solicitanteDaGeracao == solicitanteDaGeracao &&
        other.idFatura == idFatura &&
        other.referencia == referencia;
  }

  @override
  int get hashCode {
    return idCliente.hashCode ^
        cliente.hashCode ^
        documento.hashCode ^
        email.hashCode ^
        telefoneFixo.hashCode ^
        telefoneMovel.hashCode ^
        idContrato.hashCode ^
        dataHabilitacaoContrato.hashCode ^
        numeroDeBoleto.hashCode ^
        formaDeCobranca.hashCode ^
        dataVencimentoFatura.hashCode ^
        valorFatura.hashCode ^
        dataEmissaoFatura.hashCode ^
        arquivo.hashCode ^
        dataImpressaoFatura.hashCode ^
        uf.hashCode ^
        cidade.hashCode ^
        bairro.hashCode ^
        tipoLogradouro.hashCode ^
        logradouro.hashCode ^
        numero.hashCode ^
        cep.hashCode ^
        solicitanteDaGeracao.hashCode ^
        idFatura.hashCode ^
        referencia.hashCode;
  }
}
