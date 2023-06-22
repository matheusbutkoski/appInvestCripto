import 'package:app_invest/db/ativos/ativos_sqlite_database.dart';
import 'package:app_invest/pages/app_settings.dart';
import 'package:app_invest/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/ativo.dart';
import 'ativoDados.dart';
import 'listaAtivos.dart';

class addInvest extends StatefulWidget {
  addInvest({Key? key}) : super(key: key);

  @override
  State<addInvest> createState() => _addInvestState();
}

class _addInvestState extends State<addInvest> {
  late NumberFormat real;
  late Map<String, String> loc;
  late ContaRepository conta;
  List<Ativo> selecionadas = [];

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  botaoMudarMoeda() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          leading: Icon(Icons.swap_vert),
          title: Text('Usar $locale'),
          onTap: () {
            context.read<AppSettings>().setLocale(locale, name);
            Navigator.pop(context);
          },
        )),
      ],
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Seus Ativos',
        ),
        actions: [
          botaoMudarMoeda(),
        ],
        backgroundColor: Colors.amber,
      );
    } else {
      return AppBar(
        
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} Selecionadas'),
        backgroundColor: Color.fromARGB(255, 250, 100, 45),
        elevation: 1,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  for (int i = 0; i < selecionadas.length; i++) {
                    ativosSQLiteDatasource()
                        .deletarHistoricoSigla(selecionadas[i].sigla);
                    conta.vender(selecionadas[i]);
                    selecionadas.remove(selecionadas[i]);
                    conta.verificarEmBranco();
                  }
                });
              },
              icon: Icon(Icons.delete))
        ],
      );
    }
  }

  mostrarDetalhes(Ativo ativo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AtivoDados(ativo: ativo);
    }));
  }

  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    readNumberFormat();
    return Scaffold(
      appBar: appBarDinamica(),
      body: FutureBuilder<List<Ativo>>(
          future: ativosSQLiteDatasource().getAtivosUsuario(),
          builder: (BuildContext context, AsyncSnapshot<List<Ativo>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemExtent: 70,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  Ativo item = snapshot.data![index];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    leading: (selecionadas.contains(item))
                        ? CircleAvatar(
                            child: Icon(Icons.check),
                          )
                        : SizedBox(child: Image.network(item.icone), width: 45),
                    title: Text(
                      item.nome,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Text(real.format(item.preco)),
                    selected: selecionadas.contains(item),
                    selectedTileColor: Color.fromARGB(255, 247, 218, 207),
                    onLongPress: () {
                      setState(() {
                        if (selecionadas.contains(item)) {
                          selecionadas.remove(item);
                        } else {
                          selecionadas.add(item);
                        }
                      });
                    },
                    onTap: () {
                      mostrarDetalhes(item);
                    },
                  );
                },
                padding: EdgeInsets.all(12),
              );
            } else {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text("Voce não possui moedas compradas")
                  ]);
              //Center(child: CircularProgressIndicator()
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ListaAtivos();
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        hoverColor: const Color.fromARGB(255, 255, 191, 0),
      ),
    );
  }
}
