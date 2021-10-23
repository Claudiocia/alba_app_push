import 'dart:io';

import 'package:alba_app/helpers/noticia_helper.dart';
import 'package:alba_app/models/noticia_model.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceNoticiaWidget extends StatefulWidget {
  PlaceNoticiaWidget();

  @override
  PlaceNoticiaWidgetState createState() => PlaceNoticiaWidgetState();
}

class PlaceNoticiaWidgetState extends State<PlaceNoticiaWidget> {
  NoticiaHelper helperNoti = NoticiaHelper();
  NoticiaModel noti = NoticiaModel();
  List<NoticiaModel> listNotis = [];
  String path;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helperNoti.getAllNoticias().then((list) {
      setState(() {
        listNotis = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listaNoticias(),
    );
  }

  listaNoticias() {
    return ListView.separated(
        padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        separatorBuilder: (context, index) => Divider(color: Colors.black54),
        itemCount: listNotis.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              listNotis[index].dataNoticia,
              style: TextStyle(fontFamily: 'Dosis', fontSize: 16, color: Colors.black87),
            ),
            subtitle: Text(
              listNotis[index].titleNoticia,
              style: TextStyle(
                fontFamily: 'Dosis',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
            ),
            leading: Image.network(
              listNotis[index].fotoNoticia,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Qual o seu desejo?", style: TextStyle(fontFamily: 'Dosis'),),
                    content: Text(
                      listNotis[index].titleNoticia,
                      style: TextStyle(fontFamily: 'Dosis', fontWeight: FontWeight.bold),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: (){
                          _launchURL(listNotis[index].linkNoticia);

                          Navigator.of(context).pop(true);
                        },
                        child: Text("Ler a íntegra da noticia!", style: TextStyle(fontFamily: 'Dosis'),),
                      ),
                      TextButton(
                        onPressed: (){
                          _shareLink(listNotis[index].linkNoticia);
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Compartilhar", style: TextStyle(fontFamily: 'Dosis'),),
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop(true);
                          },

                          child: Text('FECHAR', style: TextStyle(fontFamily: 'Dosis'),))
                    ],
                  ));
            },
          );
        });
  }

  _launchURL(String urlNew) async {

    var url = urlNew;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _shareLink(String texto) async {
    if(Platform.isIOS){
      String text1 = texto.substring(0, 4);
      String text2 = texto.substring(5);
      String text = text1+"s:"+text2;
      print("Plataforma IOS o link é: "+ text);
      await Share.share(text);
    }else{
      print("Plataforma Android o link é: "+ texto);
      await Share.share(texto);
    }
  }

}
