import 'package:app_invest/models/posicao.dart';
import 'package:app_invest/pages/app_settings.dart';
import 'package:app_invest/pages/config.dart';
import 'package:app_invest/repositories/conta_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'addInvest.dart';
import 'conta.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Admin"),
                accountEmail: Text("admin@admin.com"),
                decoration: BoxDecoration(color: Colors.amber),
              ),
              ListTile(
                  leading: Icon(
                    Icons.wallet,
                    color: Colors.black,
                  ),
                  title: Text("Carteira"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    /* Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Home();
                          }
                        )
                      );*/
                  }),
              ListTile(
                  leading: Icon(
                    Icons.analytics,
                    color: Colors.black,
                  ),
                  title: Text("Gerenciar Ativos"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return addInvest();
                    }));
                  }),
              ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text("Conta"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Conta();
                    }));
                  }),
              ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: Text("Configurações"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Config();
                    }));
                  }),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Bem-Vindo"),
        ),
        body: const UserWallet(),
      ),
    );
  }
}

class UserWallet extends StatefulWidget {
  const UserWallet({super.key});

  @override
  State<UserWallet> createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  int index = 0;
  String graficoLabel = '';
  double graficoValor = 0;
  List<Posicao> carteira = [];
  late ContaRepository conta;

  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    final loc = context.watch<AppSettings>().locale;
    NumberFormat real =
        NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 48, bottom: 8),
            child: Text(
              'Valor da Carteira',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            real.format(conta.saldo),
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.5,
            ),
          ),
          (conta.saldo <= 0)
              ? Container(
                alignment: Alignment.center,
                child: Column(                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 120),                
                  Text("Adicione um ativo para ver sua carteira", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),)
                ]
              )
              )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(PieChartData(
                          sectionsSpace: 5,
                          centerSpaceRadius: 100,
                          sections: loadCarteira(),
                          pieTouchData: PieTouchData(
                              touchCallback: (touch) => setState(
                                    () {
                                      index = touch
                                          .touchedSection!.touchedSectionIndex;
                                      setGraficoDados(index);
                                    },
                                  )))),
                    ),
                    Column(
                      children: [
                        Text(
                          graficoLabel,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.amber,
                          ),
                        ),
                        Text(real.format(graficoValor),
                            style: TextStyle(fontSize: 28))
                      ],
                    )
                  ],
                ),
        ],
      ),
    ));
  }

  setGraficoDados(int index) {
    if (index < 0) return;

    if (index == carteira.length) {
      graficoLabel = "Saldo";
      graficoValor = conta.saldo;
    } else {
      graficoLabel = carteira[index].ativo.nome;
      graficoValor = carteira[index].ativo.preco * carteira[index].quantidade;
    }
  }

  loadCarteira() {
    setGraficoDados(index);
    carteira = conta.carteira;
    final tamanhoLista = carteira.length + 1;

    return List.generate(tamanhoLista, (i) {
      final isTouched = i == index;
      final isSaldo = i == tamanhoLista - 1;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final color = isTouched ? Colors.amberAccent : Colors.amberAccent[400];

      double porcentagem = 0;
      if (!isSaldo) {
        porcentagem =
            carteira[i].ativo.preco * carteira[i].quantidade / conta.saldo;
      } else {
        porcentagem = (conta.saldo > 0) ? conta.saldo / conta.saldo : 0;
      }
      porcentagem *= 100;

      return PieChartSectionData(
          color: color,
          value: porcentagem,
          title: '${porcentagem.toStringAsFixed(0)}%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black));
    });
  }
}
