
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {

  DB._();

  static final DB instance =DB._();

  static Database? _database;

  get database async {
    if(_database != null) return _database;
  
    return await _initDatabase();
  }

  _initDatabase() async{
    return await openDatabase(
      join(await getDatabasesPath(),'appInvest5.db'),
      version: 2,
      onCreate: _onCreate
    );   
  }

  
  _onCreate(db, version) async {
    await db.execute(_conta);
    await db.execute(_carteira);
    await db.execute(_moeda);
    await db.execute(_ativosUsuario);
    
  }  

  String get _conta => '''
    CREATE TABLE conta(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      login TEXT,
      senha TEXT,
      saldo REAL
    );
    ''';

     String get _carteira => '''
    CREATE TABLE carteira(
      sigla TEXT PRIMARY KEY,
      moeda TEXT,
      valor REAL,
      quantidade TEXT 
    );
    ''';

    String get _ativosUsuario => '''
    CREATE TABLE ativosUsuario(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data_operacao INT,
      tipo_operacao TEXT,
      quantidade TEXT,
      moeda TEXT,
      sigla TEXT
    );
    ''';

    String get _moeda => '''
   CREATE TABLE IF NOT EXISTS moeda (
        baseId TEXT PRIMARY KEY,
        sigla TEXT,
        nome TEXT,
        icone TEXT,
        preco TEXT,
        timestamp INTEGER,
        mudancaHora TEXT,
        mudancaDia TEXT,
        mudancaSemana TEXT,
        mudancaMes TEXT,
        mudancaAno TEXT,
        mudancaPeriodoTotal TEXT
      );
      ''';
      
}