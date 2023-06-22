import 'package:app_invest/pages/addInvest.dart';
import 'package:app_invest/pages/historico.dart';
import 'package:app_invest/pages/home.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
 const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int paginaAtual = 1;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina){
    setState(() {
      paginaAtual = pagina;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: PageView(
              controller: pc,
              children: [               
                addInvest(),
                Home(),
                Historico()
                
                
                                      
              ],
    onPageChanged: setPaginaAtual
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: paginaAtual,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Gerenciar Ativos"),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Carteira"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Historico"),
          ],
            onTap: (pagina) {
              pc.animateToPage(pagina, duration: Duration(milliseconds: 400), curve: Curves.ease);
            },
          backgroundColor: Color.fromARGB(255, 222, 226, 226),
          fixedColor:Colors.black,
          unselectedItemColor: Color.fromARGB(255, 83, 81, 81),
            
        ),
    );
  }
}