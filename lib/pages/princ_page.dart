import 'package:alba_app/helpers/usuario_helper.dart';
import 'package:alba_app/pages/dep_page.dart';
import 'package:alba_app/pages/home_page.dart';
import 'package:alba_app/pages/mais_page.dart';
import 'package:alba_app/pages/tel_page.dart';
import 'package:alba_app/utils/news_api.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class PrincPage extends StatefulWidget {
  PrincPage();
  @override
  _PrincPageState createState() => _PrincPageState();
}

class _PrincPageState extends State<PrincPage> {
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 4,
    minLaunches: 5,
    remindDays: 6,
    remindLaunches: 4,
    appStoreIdentifier: '1548223913',
    googlePlayIdentifier: 'br.com.nortemkt.alba_app',
  );

  //Variaveis para teste do banco
  UsuarioHelper helper = UsuarioHelper();
  NewsApi news = NewsApi();
  var hoje = DateTime.now();


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    _rateMyApp.init().then((_) {
      //print("O PRINT DO RATE É ESSE "+ _rateMyApp.shouldOpenDialog.toString());
      if(_rateMyApp.shouldOpenDialog){
        _rateMyApp.showRateDialog(
          context,
          title: 'Está gostando do App?',
          message: 'Se você gosta deste aplicativo, dedique um pouco do seu tempo para avalia-lo!'
              '\nIsso realmente nos ajuda e não deve demorar mais do que um minuto. '
              '\nSua opinião é muito importante para a ALBA!',
          rateButton: 'AVALIAR',
          noButton: 'NÃO, OBRIGADO',
          laterButton: 'MAIS TARDE',
          listener: (button) {
            switch (button) {
              case RateMyAppDialogButton.rate:
                print("Clicou no botão rate");
                break;
              case RateMyAppDialogButton.later:
                print('Cicou Mais Tarde.');
                break;
              case RateMyAppDialogButton.no:
                print('Clicou em Não.');
                break;
            }
            return true;
          },
          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          onDismissed: () =>
              _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
        );
      }
    });
    news.loadNews().then((value){});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dosis'),
      title: "ALBA APP",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,
          ),
        ),
        drawer: CustomDrawer(),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: new GridView.builder(
              itemCount: _filesNome.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.0,
                  crossAxisCount: 1),
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  elevation:  10,
                  margin: EdgeInsets.all(10),
                  child: new InkResponse(
                    child: Image.asset(
                      _filesNome[index],
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      _routesNavigations(context, index);
                    },
                  ),
                );
              }),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  List<String> _filesNome = [
    'assets/images/abt_noticias.jpg',
    'assets/images/abt_deputados.jpg',
    'assets/images/abt_tel_uteis.jpg',
    'assets/images/abt_mais_alba.jpg',
  ];

  _routesNavigations(BuildContext context, int id) {
    switch (id) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DepPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TelPage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MaisPage()));
        break;
    }
  }
}