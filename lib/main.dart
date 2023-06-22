import 'package:app_invest/pages/Login%20e%20Cadastro/login.dart';
import 'package:app_invest/pages/app_settings.dart';
import 'package:app_invest/pages/home.dart';
import 'package:app_invest/repositories/ativo_repository.dart';
import 'package:app_invest/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=> AtivoRepository()),
    ChangeNotifierProvider(create: (context)=> ContaRepository(ativos: context.read<AtivoRepository>())),
    ChangeNotifierProvider(create: (context)=> AppSettings()),
    ], 
    child: MyApp(),
    ),
     );
}

class MyApp extends StatelessWidget{ 
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'App Investimentos',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: Login(),
        );
       
    }
  }

