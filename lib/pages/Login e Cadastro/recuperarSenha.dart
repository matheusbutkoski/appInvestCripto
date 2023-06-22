import 'package:app_invest/pages/Login%20e%20Cadastro/login.dart';
import 'package:app_invest/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class RecuperarSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Recuperar sua senha"),
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: _Body(),
      ),

    );
  }
}



class _Body extends StatelessWidget {
  String email = '';
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top: 40, left: 40, right: 40),
      child: ListView(
        children: [
          textMaior(),
          SizedBox(height: 30),
          textMenor(),
          SizedBox(height: 30),
          fieldEmail(),
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
                   Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  child: Text("Enviar código!", style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),),
                ),
              ),
        )
          ],
      )
    );
  }

  Widget textMaior(){
  return Text(
    "Esqueceu sua senha?",
    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
    textAlign:  TextAlign.center,
  );
}

Widget textMenor(){
  return Text(
    "Informe seu e-mail associado a sua conta para recuperar sua senha",
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    textAlign:  TextAlign.center,
  );
}

Widget fieldEmail(){
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
    onChanged: (text){
      email = text;
    },
  );
}
}