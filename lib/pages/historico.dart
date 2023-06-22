import 'package:app_invest/db/ativos/ativos_sqlite_database.dart';
import 'package:app_invest/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  late ContaRepository conta;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
          title: const Text("Historico"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
              onPressed: (){
                setState(() {
                  ativosSQLiteDatasource().deletarHistorico();
                });
              
            }, child: Text(
              'Excluir Historico', style: TextStyle(color: Colors.black),
            ))
          ],
        
        ),
        body: loadHistorico(),
    );
  }
  loadHistorico() {
    final historico = conta.historico;
    final date = DateFormat('dd/MM/yyyy - hh:mm');
    List<Widget> widgets = [];

    for (var operacao in historico) {
      widgets.add(ListTile(
        title: Text(operacao.ativo.nome+' - '+ operacao.tipoOperacao),
        subtitle: Text(date.format(operacao.dataOperacao)),
        trailing:
            Text('Valor da Carteira \n'+real.format((operacao.ativo.preco * operacao.quantidade))),
      ));
      widgets.add(Divider());
    }
    return Column(
      children: widgets,
    );
  }
}