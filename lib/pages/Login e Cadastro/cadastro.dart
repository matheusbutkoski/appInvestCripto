import 'package:app_invest/db/perfil/perfil_sqlite_datasorce.dart';
import 'package:app_invest/pages/Login%20e%20Cadastro/login.dart';
import 'package:app_invest/pages/home.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preencha os campos'),
        backgroundColor: Colors.amber,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  String _nome = '';

  String _email = '';

  String _senha = '';

  double _saldo = 0;

  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(children: [
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
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: () {
                    perfilSQLiteDatasource()
                        .inserirPerfil(_nome, _email, _senha, _saldo);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  child: Text(
                    "Cadastrar!",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
            )
          ]),
        ));
  }

  Widget fieldName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'O campo nome é obrigatório';
        }
      },
      onChanged: (value) => setState(() {
        _nome = value;
      }),
      decoration: InputDecoration(
          labelText: "Nome",
          labelStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )),
    );
  }

  Widget fieldEmail() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'O campo e-mail é obrigatório';
        }
      },
      onChanged: (value) => setState(() {
        _email = value;
      }),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "E-mail",
          labelStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )),
    );
  }

  Widget fieldSenha() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'O campo senha é obrigatório';
        }
      },
      onChanged: (value) => setState(() {
        _senha = value;
      }),
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Senha",
          labelStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )),
    );
  }
}
