import 'dart:convert';

class BoletoModel {
  final int idCliente;
  final String? cliente;
  final String? documento;
  final String? email;
  final String? telefoneFixo;
  final String? telefoneMovel;
  final int idContrato;
  final String? dataHabilitacaoContrato;
  final String? numeroDeBoleto;
  final String? formaDeCobranca;
  final String? dataVencimentoFatura;
  final String? valorFatura;
  final String? dataEmissaoFatura;
  final String? arquivo;
  final String? dataImpressaoFatura;
  final String? uf;
  final String? cidade;
  final String? bairro;
  final String? tipoLogradouro;
  final String? logradouro;
  final String? numero;
  final String? cep;
  final String? solicitanteDaGeracao;
  final int idFatura;
  final String? referencia;
  BoletoModel({
    required this.idCliente,
    this.cliente,
    this.documento,
    this.email,
    this.telefoneFixo,
    this.telefoneMovel,
    required this.idContrato,
    this.dataHabilitacaoContrato,
    this.numeroDeBoleto,
    this.formaDeCobranca,
    this.dataVencimentoFatura,
    this.valorFatura,
    this.dataEmissaoFatura,
    this.arquivo,
    this.dataImpressaoFatura,
    this.uf,
    this.cidade,
    this.bairro,
    this.tipoLogradouro,
    this.logradouro,
    this.numero,
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

  factory BoletoModel.fromMap(Map<String, String> map) {
    return BoletoModel(
      idCliente: int.tryParse(map['ID Cliente'].toString()) ?? 0,
      cliente: map['Cliente'] ?? '',
      documento: map['Documento'] ?? '',
      email: map['Email'] ?? '',
      telefoneFixo: map['Telefone Fixo'] ?? '',
      telefoneMovel: map['Telefone Movel'] ?? '',
      idContrato: int.tryParse(map['ID Contrato'].toString()) ?? 0,
      dataHabilitacaoContrato: map['Data Habilitacao contrato'] ?? '',
      numeroDeBoleto: map['Número de Boleto'] ?? '',
      formaDeCobranca: map['Forma de Cobrança'] ?? '',
      dataVencimentoFatura: map['Data Vencimento Fatura'] ?? '',
      valorFatura: map['Valor Fatura'] ?? '',
      dataEmissaoFatura: map['Data Emissao Fatura'] ?? '',
      arquivo: map['Arquivo'] ?? '',
      dataImpressaoFatura: map['Data Impressão Fatura'] ?? '',
      uf: map['UF'] ?? '',
      cidade: map['Cidade'] ?? '',
      bairro: map['Bairro'] ?? '',
      tipoLogradouro: map['Tipo Logradouro'] ?? '',
      logradouro: map['Logradouro'] ?? '',
      numero: map['Numero'] ?? 's/n',
      cep: map['CEP'] ?? '',
      solicitanteDaGeracao: map['Solicitante da Geração'] ?? '',
      idFatura: int.tryParse(map['ID Fatura'].toString()) ?? 0,
      referencia: map['Referencia'] ?? '',
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
