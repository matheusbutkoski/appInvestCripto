import 'package:app_invest/pages/formInvest.dart';
import 'package:app_invest/widgets/grafico_historico.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/ativo.dart';
import '../repositories/ativo_repository.dart';

class AtivoDados extends StatefulWidget {
  Ativo ativo; 
  AtivoDados({Key? key, required this.ativo}) :super(key: key);

  @override
  State<AtivoDados> createState() => _AtivoDadosState();
}

 

class _AtivoDadosState extends State<AtivoDados> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late AtivoRepository ativos;
  Widget grafico = Container();
  bool graficoLoaded = false;

  getGrafico(){
    if(! graficoLoaded){
      grafico = GraficoHistorico(ativo: widget.ativo);
      graficoLoaded = true;
    }
    return grafico;
  }
     
  mostrarForm(Ativo ativo){
  Navigator.push(context, MaterialPageRoute(builder: (context){
      return formInvest(ativo: ativo);
      }
      )
      );
    
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ativo.nome),
        backgroundColor: Colors.amber,
      ),
      body: Padding(padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
               Image.network(widget.ativo.icone, scale: 2.5),
              Container(width: 10),
              Text(
                real.format(widget.ativo.preco),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              )                
            ],
          )
          ),
        SizedBox(height: 30),
        getGrafico(),
        SizedBox(height: 30),

        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: (){
                    mostrarForm(widget.ativo);                    
                  },
                  child: Text("Investir!", style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),),
                  
                ),
              ),
        )
        ],
      ),
      )    
    );
  }
}