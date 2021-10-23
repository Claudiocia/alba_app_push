import 'package:alba_app/pages/dep_page.dart';
import 'package:alba_app/pages/home_page.dart';
import 'package:alba_app/pages/mais_page.dart';
import 'package:alba_app/pages/redessociais_page.dart';
import 'package:alba_app/pages/sobrealba_page.dart';
import 'package:alba_app/pages/sobreapp_page.dart';
import 'package:alba_app/pages/tel_page.dart';
import 'package:alba_app/pages/todosdep_page.dart';
import 'package:flutter/material.dart';


class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final int page;

  DrawerTile(this.icon, this.text, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          _routesNavigations(context, page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                  color: Colors.black,
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Dosis',
                  fontSize: 16.0,
                  color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      case 4:
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => PlaceRedesSociaisWidget()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceSobreAlbaWidget()));
        break;
      case 6:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceSobreAppWidget()));
        break;
      case 7:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceTodosDepWidget()));
        break;
    }
  }
}
