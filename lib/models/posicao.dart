import 'package:app_invest/models/ativo.dart';

class Posicao {
  Ativo ativo;
  double quantidade;
  double valor;

  Posicao({
    required this.valor,
    required this.ativo,
    required this.quantidade
  });

}