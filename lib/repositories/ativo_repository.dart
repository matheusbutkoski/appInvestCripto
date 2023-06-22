import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

import '../db/db.dart';
import '../models/ativo.dart';

class AtivoRepository extends ChangeNotifier{
  List<Ativo> _tabela = [];

  List<Ativo> get tabela => _tabela;
  
  AtivoRepository(){
    
    _setupDadosTableAtivo();
    _readAtivosTable();
  }

  _readAtivosTable() async{
    Database db = await DB.instance.database;
    List resultados = await db.query('moeda');

   _tabela = resultados.map((row) {
      return Ativo(
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
    }).toList();

    notifyListeners();
  }

  getHistoricoMoeda(Ativo ativo) async {
    final response = await http.get(
      Uri.parse(
        'https://api.coinbase.com/v2/assets/prices/${ativo.baseId}?base=BRL',
      ),
    );
    List<Map<String, dynamic>> precos = [];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Map<String, dynamic> moeda = json['data']['prices'];

      precos.add(moeda['hour']);
      precos.add(moeda['day']);
      precos.add(moeda['week']);
      precos.add(moeda['month']);
      precos.add(moeda['year']);
      precos.add(moeda['all']);
    }

    return precos;
  }

  _ativosTableIsEmpty() async {
    Database db = await DB.instance.database;
    List resultados = await db.query('moeda');
    return resultados.isEmpty;
  }

  _setupDadosTableAtivo() async {
    if(await _ativosTableIsEmpty()){
      String uri = 'https://api.coinbase.com/v2/assets/search?base=BRL';
      
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200){
        final json = jsonDecode(response.body);

        final List<dynamic> ativos = json['data'];
        Database db = await DB.instance.database;
        Batch batch = db.batch();

        ativos.forEach((ativo){        
          final preco = ativo['latest_price'];
          final timestamp = DateTime.parse(preco['timestamp']);

          batch.insert('moeda', {
            'baseId': ativo['id'],
            'sigla': ativo['symbol'],
            'nome': ativo['name'],
            'icone': ativo['image_url'],
            'preco': ativo['latest'],
            'timestamp': timestamp.millisecondsSinceEpoch,
            'mudancaHora': preco['percent_change']['hour'].toString(),
            'mudancaDia': preco['percent_change']['day'].toString(),
            'mudancaSemana': preco['percent_change']['week'].toString(),
            'mudancaMes': preco['percent_change']['month'].toString(),
            'mudancaAno': preco['percent_change']['year'].toString(),
            'mudancaPeriodoTotal': preco['percent_change']['all'].toString()
          });
         });

         await batch.commit(noResult: true);

      }

    }
  }

  

}