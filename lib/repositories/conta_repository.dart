import 'dart:ffi';

import 'package:app_invest/db/db.dart';
import 'package:app_invest/models/ativo.dart';
import 'package:app_invest/models/ativosUsuario.dart';
import 'package:app_invest/models/posicao.dart';
import 'package:app_invest/repositories/ativo_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _carteira = [];
  List<ativosUsuario> _historico = [];
  double _saldo = 0;
  AtivoRepository ativos;

  get saldo {
    return _saldo;
  }

  List<Posicao> get carteira {
    return _carteira;
  }

   List<ativosUsuario> get historico {
    return _historico;
  }

  ContaRepository({required this.ativos}) {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    await _getCarteira();
    await _getHistorico();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
    return _saldo;
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  comprar(Ativo ativo, double valor) async {
    db = await DB.instance.database;

    await db.transaction((txn) async {
      // Verificar se a ativo já foi comprada
      final posicaoativo = await txn.query(
        'carteira',
        where: 'sigla = ?',
        whereArgs: [ativo.sigla],
      );
      // Se não tem a ativo ainda, insert
      if (posicaoativo.isEmpty) {
        await txn.insert('carteira', {
          'sigla': ativo.sigla,
          'moeda': ativo.nome,
          'valor': valor,
          'quantidade': (valor / ativo.preco).toString(),
        });
      } else {
        final atual = double.parse(posicaoativo.first['quantidade'].toString());
        await txn.update(
          'carteira',
          {'quantidade': ((valor / ativo.preco) + atual).toString()},
          where: 'sigla = ?',
          whereArgs: [ativo.sigla],
        );
      }

      // Inserir o histórico
      await txn.insert('ativosUsuario', {
        'moeda': ativo.nome,
        'sigla': ativo.sigla,
        'quantidade': (valor / ativo.preco).toString(),
        'tipo_operacao': 'Compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch

      });

      await txn.update('conta', {'saldo': saldo + valor});
    });

    await _initRepository();
    notifyListeners();
  }

  vender(Ativo ativo) async {
    db = await DB.instance.database;
    double valorFinal = 0;

    await db.transaction((txn) async {
      List<Map> dbResult = await txn.rawQuery(
          'select quantidade, valor from carteira where sigla like ?',
          [ativo.sigla]);
      List<Posicao> posicoes = [];
      for (var row in dbResult) {
        Posicao posicao = Posicao(
            valor: row['valor'],
            ativo: ativo,
            quantidade: double.parse(row['quantidade']));
        posicoes.add(posicao);
      }
      for (int i = 0; i < posicoes.length; i++) {
        valorFinal = valorFinal + posicoes[i].valor;
      }

      await txn
          .rawUpdate('delete from carteira where sigla like ?', [ativo.sigla]);

       //Inserir o histórico

      await txn.insert('ativosUsuario', {
        'moeda': ativo.nome,
        'sigla': ativo.sigla,
        'quantidade': (valorFinal/ ativo.preco).toString(),
        'tipo_operacao': 'Venda',
        'data_operacao': DateTime.now().millisecondsSinceEpoch

      });

      await txn.update('conta', {'saldo': saldo - valorFinal});
    });

    await _initRepository();
    notifyListeners();
  }

  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    posicoes.forEach((posicao) {
      Ativo moeda = ativos.tabela.firstWhere(
        (m) => m.sigla == posicao['sigla'],
      );
      _carteira.add(Posicao(
        valor: posicao['valor'],
        ativo: moeda,
        quantidade: double.parse(posicao['quantidade']),
      ));
    });
    notifyListeners();
  }

  _getHistorico() async {
    _historico = [];
    List operacoes = await db.query('ativosUsuario');
    operacoes.forEach((operacao) {
       Ativo atv = ativos.tabela.firstWhere(
        (m) => m.sigla == operacao['sigla'],
      );
      _historico.add(
        ativosUsuario(
          dataOperacao:DateTime.fromMillisecondsSinceEpoch(operacao['data_operacao']),
          tipoOperacao: operacao['tipo_operacao'],
          ativo: atv,
          quantidade: double.parse(operacao['quantidade']),
        ),
      );
    });
    notifyListeners();
  }

  verificarEmBranco() async {
    Database db = await DB.instance.database;
    List<Map> dbResult = await db.rawQuery('SELECT * from carteira');

    if (dbResult.isEmpty) {
      setSaldo(0);
    }
  }
}
