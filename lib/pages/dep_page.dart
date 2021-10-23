import 'package:alba_app/helpers/usuario_helper.dart';
import 'package:alba_app/pages/deputados_page.dart';
import 'package:alba_app/pages/maisalba_page.dart';
import 'package:alba_app/pages/noticias_page.dart';
import 'package:alba_app/pages/pesq_telefones_page.dart';
import 'package:alba_app/pages/telefones_page.dart';
import 'package:alba_app/pages/todosdep_page.dart';
import 'package:alba_app/presentation/custom_icons_icons.dart';
import 'package:alba_app/utils/news_api.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

import '../splashscreen.dart';

class DepPage extends StatefulWidget {
  DepPage();
  @override
  _DepPageState createState() => _DepPageState();
}

class _DepPageState extends State<DepPage> {

  //Variaveis para teste do banco
  UsuarioHelper helper = UsuarioHelper();
  NewsApi news = NewsApi();

  //Variaves usadas nesta classe
  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    news.loadNews().then((value){
      //print("Resultado da classe News: $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dosis'),
      title: "ALBA APP",
      home: Scaffold(
        appBar: botaoBarra(),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.notic),
              label: 'Notícias',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.dep_par),
              label: 'Deputados',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.tel_uteis),
              label: 'Tel Uteis',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.alba_mais),
              label: 'Mais Alba',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blueAccent, //amber[800],
          selectedLabelStyle: TextStyle(fontFamily: 'Dosis', fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontFamily: 'Dosis'),
          onTap: onItemTapped,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
  List<Widget> widgetOptions = <Widget>[
    PlaceNoticiaWidget(),
    PlaceDeputadoWidget(),
    PlaceTelefoneWidget(),
    PlaceMaisAlbaWidget(),
  ];

  botaoBarra(){
    switch (selectedIndex){
      case 0:
        return AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "Recarregar",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SplashScreenPage()));
              },
            ),
          ],
        );
        break;
      case 1:
        return AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,),
          actions: <Widget>[
            IconButton(
              icon: Icon(CustomIcons.dep),
              tooltip: "Listar todos dep",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PlaceTodosDepWidget()));
              },
            ),
          ],
        );
        break;
      case 2:
        return AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "Pesquisar",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PlacePesqTelefonesWidget()));
              },
            ),
          ],
        );
        break;
      case 3:
        return AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,),
        );
        break;
    }
  }

}
