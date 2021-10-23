import 'package:alba_app/helpers/bd_plunge.dart';
import 'package:alba_app/main.dart';
import 'package:alba_app/utils/livros_api_bd.dart';
import 'package:alba_app/utils/news_api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Connectivity _connectivity = Connectivity();
  NewsApi news = NewsApi();
  LivrosApiBd livros = LivrosApiBd();
 // PackageInfo packageInfo;
  var hoje = DateTime.now();
  //ControleHelper controleHelper = ControleHelper();
  //ControleModel controle = ControleModel();
  //VersionMyApp _versionMyApp = VersionMyApp();

  /*
  Future initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
    return packageInfo;
  }

   */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivity.checkConnectivity().then((connectivityResult){
      _conectivityStatus(connectivityResult);
    });

    /*
    controleHelper.getControle().then((value){
      if(value != null){
        controle = value;
      }else{
        controle = null;
      }
    });

     */
  }

  /*
  saveControle() {
    Map<String, dynamic> controlMap = {
    "versao_atual" : packageInfo.version.toString(),
    "ultimaVerific" : (hoje.add(new Duration(days: -10))).toString(),
    "proximaVerific" : hoje.toString(),
    };
    controle = ControleModel.fromMap(controlMap);
    controleHelper.saveControle(controle);
  }

   */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: SplashScreenWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  _conectivityStatus(ConnectivityResult connectivityResult) async {
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      await news.loadNews().then((value) {});
      await livros.atualizarBdLivr().then((value){});
      //await _versionMyApp.loadVersion().then((value) {});
      //await initPackageInfo();
      /*
      if(controle == null && packageInfo != null){
        saveControle();
      }

       */
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verifique sua conexão de rede!!",
            style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          )
      );
    }
  }

}

class SplashScreenWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 7,
          backgroundColor: Color(0xFF1b8adb),
          navigateAfterSeconds: MyApp(),
          loaderColor: Colors.transparent,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 105,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/marca_branca.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 105,
                width: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/marca_ascom.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

