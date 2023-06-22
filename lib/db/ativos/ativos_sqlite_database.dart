import 'package:app_invest/db/db.dart';
import 'package:app_invest/models/ativo.dart';
import 'package:app_invest/models/posicao.dart';
import 'package:app_invest/repositories/ativo_repository.dart';
import 'package:sqflite/sqflite.dart';

class ativosSQLiteDatasource {
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DB.instance.database;
    return await db.query("conta");
  }

  Future<List<Ativo>> getAllAtivo() async {
    Database db = await DB.instance.database;
    List<Map> dbResult = await db.rawQuery('SELECT * from moeda');
    List<Ativo> ativos = [];
    for (var row in dbResult) {
      Ativo ativo = Ativo(
        baseId: row['baseId'],
        icone: row['icone'],
        sigla: row['sigla'],
        nome: row['nome'],
        preco: double.parse(row['preco']),
        timestamp: DateTime.fromMillisecondsSinceEpoch(row['timestamp']),
        mudancaHora: double.parse(row['mudancaHora']),
        mudancaDia: double.parse(row['mudancaDia']),
        mudancaSemana: double.parse(row['mudancaSemana']),
        mudancaMes: double.parse(row['mudancaMes']),
        mudancaAno: double.parse(row['mudancaAno']),
        mudancaPeriodoTotal: double.parse(row['mudancaPeriodoTotal']),
      );
      ativos.add(ativo);
    }
    return ativos;
  }

  Future<List<Ativo>> getAtivosUsuario() async { 
    List<Ativo> _ativos = [];
    AtivoRepository ativos = AtivoRepository();
    Database db = await DB.instance.database;
    List<Map> dbResult = await db.rawQuery('SELECT DISTINCT sigla from carteira');
    dbResult.forEach((posicao) {
      Ativo moeda = ativos.tabela.firstWhere(
        (m) => m.sigla == posicao['sigla'],
      );
      _ativos.add(moeda);
    });
  return _ativos;
  }


   Future<void> deletarHistoricoSigla(sigla) async {
    Database db = await DB.instance.database;
    await db.transaction((txn) async {
      await txn.rawUpdate('delete from carteira where sigla like ?', [sigla]);
    });
  }

  Future<void> deletarHistorico() async {
    Database db = await DB.instance.database;
    await db.transaction((txn) async {
      await txn
          .rawUpdate('delete from ativosUsuario');
    });
  }

}
