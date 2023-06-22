import 'package:app_invest/models/ativo.dart';

class ativosUsuario {
  DateTime dataOperacao;
  String tipoOperacao;
  Ativo ativo;
  double quantidade;

  ativosUsuario({
    required this.dataOperacao,
    required this.tipoOperacao,
    required this.ativo,
    required this.quantidade,
  });
}