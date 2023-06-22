import 'package:app_invest/pages/formInvest.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/ativo.dart';
import '../repositories/ativo_repository.dart';

class ListaAtivos extends StatefulWidget {
  const ListaAtivos({super.key});

  @override
  State<ListaAtivos> createState() => _ListaAtivosState();
}

class _ListaAtivosState extends State<ListaAtivos> {
   late List<Ativo> tabela;
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    late AtivoRepository ativos;

    mostrarForm(Ativo ativo){
      Navigator.push(context, MaterialPageRoute(builder: (context){
      return formInvest(ativo: ativo);
      }
      )
      );
    }

  @override
 Widget build(BuildContext context) {
  ativos = context.watch<AtivoRepository>();
  tabela = ativos.tabela;      
    return Scaffold(
      appBar: AppBar(
        title: Text("Ativos Disponíveis"),
        backgroundColor: Colors.amber,
      ),       
      body: ListView.separated(itemBuilder:(BuildContext context, int ativo){
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),

          leading: SizedBox(
          child: Image.network(tabela[ativo].icone),
          width: 40
            ),

          title: Text(tabela[ativo].nome, style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),),

          trailing: Text(real.format(tabela[ativo].preco)),

         
          onTap: (){
            mostrarForm(tabela[ativo]);
          },

        );
      },
      
      padding: EdgeInsets.all(16), separatorBuilder: (_, ___) => Divider(), itemCount: tabela.length), 
    );
  }
}