import 'package:alba_app/models/usuario_model.dart';
import 'package:alba_app/presentation/custom_icons_icons.dart';
import 'package:alba_app/widgets/tile/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {

  String usuario;
  UsuarioModel user = UsuarioModel();
  List<Color> colorsList = [const Color.fromARGB(255, 203, 236, 241), const Color.fromARGB(255, 253, 181, 168)];

  @override
  Widget build(BuildContext context) {

    Widget buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colorsList,
        ),
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 10.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child:Image.asset("assets/images/ic_marcar_azul.png"),
                      width: 100.0,
                    ),
                    Positioned(
                      top: 12.0,
                      left: 110.0,
                      child: Text(
                        "Assembleia\nLegislativa\nda Bahia",
                        style: TextStyle(fontFamily: 'Dosis',  fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UsuarioModel>(
                        builder: (context, child, model){
                          user = model.userLogado();
                          if(user == null){
                            usuario = "Visitante";
                          }else {
                            usuario = user.nome;
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Olá, $usuario",
                                style: TextStyle(fontFamily: 'Dosis', fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(CustomIcons.notic, "Notícias", 0),
              DrawerTile(CustomIcons.dep_par, "Deputados", 1),
              DrawerTile(CustomIcons.dep, "Todos Dep.", 7),
              DrawerTile(CustomIcons.tel_uteis, "Telefones Úteis", 2),
              DrawerTile(CustomIcons.alba_mais, "Mais ALBA", 3),
              Divider(),
              DrawerTile(CustomIcons.compart, "Redes Sociais", 4),
              DrawerTile(CustomIcons.inform, "Sobre a ALBA", 5),
              DrawerTile(CustomIcons.sobre_app, "Sobre o App", 6),
            ],
          )
        ],
      ),
    );
  }
}