import 'package:app_invest/pages/home.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Preencha os campos'),
          backgroundColor: Colors.amber,
        ),
        body : _Body(),
    );
  }
  
}

Widget fieldName(){
  return TextFormField(
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ), 
            );
}

Widget fieldEmail(){
  return TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ), 
            );
}

Widget fieldSenha(){
  return TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ), 
            );
}


class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: [
            fieldName(),
            SizedBox(height: 30),
            fieldEmail(),
            SizedBox(height: 30),
            fieldSenha(),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Home();
                  })
                );
                  },
                  child: Text("Cadastrar!", style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),),
                ),
              ),
        )

          ]
        ),
      )
    );
  }
}