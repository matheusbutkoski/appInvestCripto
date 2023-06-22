import 'package:app_invest/pages/recuperarSenha.dart';
import 'package:flutter/material.dart';

import 'cadastro.dart';
import 'home.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.network('https://cdn.pixabay.com/photo/2016/11/30/21/55/coin-1873955_960_720.png')
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ), 
            ),
            SizedBox(
              height: 10,
            ),
             TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ), 
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(child: const Text("Esqueci a senha"), onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RecuperarSenha();
                  })
                );
                
              },)
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                     const Color.fromARGB(255, 249, 204, 71),
                     const Color.fromARGB(255, 241, 197, 63),
                     
                  ]
                ),
                borderRadius: BorderRadius.all(Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Home();
                  })
                  )
                },
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                   Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                        
                      ),
                      Container(
                        child: SizedBox(child: Image.network("https://cdn.pixabay.com/photo/2012/04/10/23/49/graph-27130_960_720.png"),
                        height: 28,
                        width: 28,),
                      )
                  ],
                )
                ),
                      
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xFF3C5A99),
                borderRadius: BorderRadius.all(Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(onPressed: () => {},
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                   Text(
                        "Entrar com Facebook",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                        
                      ),
                      
                  ],
                )
                ),
                      
              ),
            ),
            SizedBox(height: 30 ),

             Container(
              height: 60,
              alignment: Alignment.center,
              child: TextButton(child: const Text("Nao possui conta? Cadastre-se aqui!", style: TextStyle(fontSize: 18),), onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Cadastro();
                  })
                  );
                
              },)
            ),
          ]
        ),
      ),
    );
  }
}