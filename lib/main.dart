import 'package:alba_app/models/usuario_model.dart';
import 'package:alba_app/pages/cadastro_page.dart';
import 'package:alba_app/pages/princ_page.dart';
import 'package:alba_app/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'helpers/usuario_helper.dart';

void main() => runApp(SplashScreenPage());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UsuarioModel userLogado = UsuarioModel();
  UsuarioHelper userHelper = UsuarioHelper();
  bool _enableConsentButton = false;
  bool _requireConsent = true;

  var user3;
  int x = 0;
  Future<UsuarioModel> query2;

  Future<UsuarioModel> _queryUser() async{
    await userHelper.getUser().then((value){
      if(value != null){
        user3 = value;
      }else{
        user3 = "Inexiste";
      }
    });
    return user3;
  }

  Future<void> initPlatformState() async{
    if(!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.setAppId("ba78084d-3d69-46fa-a555-e7ae014c6549");

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted){
      print("Permissão aceita: $accepted");
    });

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    query2 = _queryUser();
    // userLogado.userLogado();

  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    // userLogado.userLogado();
  }
  @override
  Widget build(BuildContext context) {
    var value2;
    return Container(
        child: FutureBuilder(
            future: query2,
            builder: (BuildContext context, AsyncSnapshot<UsuarioModel> snapshot){
              final state = snapshot.connectionState;
              if(state == ConnectionState.done) {
                value2 = "Carregando";
                if (snapshot.hasError) {
                  value2 = "Erro.. ${snapshot.error.toString()}";
                } else {
                  value2 = snapshot.data;
                }
              }

              if(value2 == "Carregando"){

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/images/marca_alba_s.jpg",
                        width: 200.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              }else if (user3 == "Inexiste"){

                return ScopedModel<UsuarioModel>(
                  model: UsuarioModel(),
                  child: MaterialApp(
                    theme: ThemeData(fontFamily: 'Dosis'),
                    home: PlaceCadastroWidget(),
                    debugShowCheckedModeBanner: false,
                  ),
                );
              }else {
                return ScopedModel<UsuarioModel>(
                  model: UsuarioModel(),
                  child: MaterialApp(
                    theme: ThemeData(fontFamily: 'Dosis'),
                    home: PrincPage(),
                    debugShowCheckedModeBanner: false,
                  ),
                );
              }
            }
        )
    );
  }

}
