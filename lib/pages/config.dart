import 'package:flutter/material.dart';

class Config extends StatelessWidget {
  const Config({super.key});

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
                    leading: Icon(Icons.palette, color: Colors.black,),
                    title: Text("Tema"),
           ),
                ListTile(
                    leading: Icon(Icons.notifications_rounded, color: Colors.black,),
                    title: Text("Notificações"),
           ),

           ListTile(
                    leading: Icon(Icons.shield, color: Colors.black,),
                    title: Text("Segurança"),
                    

           ),
           ListTile(
                    leading: Icon(Icons.accessibility_new_rounded, color: Colors.black,),
                    title: Text("Acessibilidade"),
           ),

        ],
      )
    );
  }
}