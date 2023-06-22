import 'package:app_invest/db/db.dart';
import 'package:sqflite/sqflite.dart';


class perfilSQLiteDatasource{
   Future inserirPerfil(nome, email, senha, saldo) async {
    try {
      final Database db = await DB.instance.database;
      await db.rawInsert('''insert into conta(
              nome,
              login,
              senha,
              saldo)
              values(
                '${nome}','${email}','${senha}','${saldo}') 
              ''');
      queryAllRows();
    } catch (ex) {
      return;
    }
  }

   Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DB.instance.database;
    return await db.query("conta");
  }


  Future<bool> getPerfilLogin(login, senha) async {
    Database db = await DB.instance.database;
    List<Map> dbResult = await db.rawQuery(
        'SELECT * from conta where login = ? and senha = ?',[login,senha]);
    
    if (dbResult.isEmpty)
      return false;
    else
      return true;
  }

}