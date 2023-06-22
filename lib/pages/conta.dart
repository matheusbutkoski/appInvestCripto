import 'package:flutter/material.dart';

class Conta extends StatelessWidget {
  const Conta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sua Conta'),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          ListTile(
                    leading: Icon(Icons.person, color: Colors.black,),
                    title: Text("Meu Perfil"),
           ),
                ListTile(
                    leading: Icon(Icons.lock, color: Colors.black,),
                    title: Text("Privacidade e Uso"),
           ),

           ListTile(
                    leading: Icon(Icons.key, color: Colors.black,),
                    title: Text("Alterar Senha"),
                    

           ),
           ListTile(
                    leading: Icon(Icons.headphones, color: Colors.black,),
                    title: Text("Suporte ao Cliente"),
           ),
        ],
      )
    );
  }
}