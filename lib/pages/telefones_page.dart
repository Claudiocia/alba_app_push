import 'package:alba_app/helpers/setor_helper.dart';
import 'package:alba_app/models/setor_model.dart';
import 'package:alba_app/utils/utilidades_gerais.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTelefoneWidget extends StatefulWidget {
  PlaceTelefoneWidget();
  @override
  _PlaceTelefoneWidgetState createState() => _PlaceTelefoneWidgetState();
}

class _PlaceTelefoneWidgetState extends State<PlaceTelefoneWidget> {
  SetorModel setor = SetorModel();
  SetorHelper helperSetor = SetorHelper();
  List<SetorModel> listSetors = List.empty();
  UtilidadeGeral utils = UtilidadeGeral();

  @override
  void initState() {
    helperSetor.getAllSetors().then((list){
      setState(() {
        listSetors = list;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listaTelefones(),
    );
  }

  listaTelefones() {
    return ListView.separated(
        padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        separatorBuilder: (context, index) => Divider(color: Colors.black54),
        itemCount: listSetors.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: CircleAvatar(
                backgroundColor: utils.gerarColor(),
                foregroundColor: Colors.white,
                radius: 28,
                child: Text(
                  _initialArea(listSetors[index].areaSetor),
                  style: TextStyle(
                    fontFamily: 'Dosis',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              title: Text(
                listSetors[index].areaSetor,
                style: TextStyle(
                  fontFamily: 'Dosis',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(listSetors[index].nomeSetor +
                  "\n" +
                  _testeNome(listSetors[index].respSetor) +
                  "\n" +
                  listSetors[index].telSetor,
                style: TextStyle(fontFamily: 'Dosis'),
              ),
              onTap: () {
                if(listSetors[index].emailSetor == "null"){
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(listSetors[index].nomeSetor,
                        style: TextStyle(fontFamily: 'Dosis'),
                        ),
                        content: Text(listSetors[index].respSetor +
                            "\nEmail: " +
                            listSetors[index].emailSetor +
                            "\nTel.: (071)" +
                            listSetors[index].telSetor,
                          style: TextStyle(fontFamily: 'Dosis'),
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: null,
                              child: Text('Enviar email', style: TextStyle(fontFamily: 'Dosis'),)),
                          TextButton(
                              onPressed: () {
                                _makePhoneCall("071" + (listSetors[index].telSetor).substring(0, 9));
                                Navigator.of(context).pop(true);
                              },
                              child: Text('LIGAR', style: TextStyle(fontFamily: 'Dosis'),)),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(
                                  true),
                              child: Text('FECHAR', style: TextStyle(fontFamily: 'Dosis')))
                        ],
                      )
                  );
                }else {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: Text(listSetors[index].nomeSetor, style: TextStyle(fontFamily: 'Dosis')),
                            content: Text(listSetors[index].respSetor +
                                "\nEmail: " +
                                listSetors[index].emailSetor +
                                "\nTel.: (071)" +
                                listSetors[index].telSetor, style: TextStyle(fontFamily: 'Dosis')),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    _makeEmailCall(listSetors[index]
                                        .emailSetor);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Enviar email', style: TextStyle(fontFamily: 'Dosis'))),
                              TextButton(
                                  onPressed: () {
                                    _makePhoneCall("071" +
                                        (listSetors[index].telSetor).substring(
                                            0, 9));
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('LIGAR', style: TextStyle(fontFamily: 'Dosis'))),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(
                                          true),
                                  child: Text('FECHAR', style: TextStyle(fontFamily: 'Dosis')))
                            ],
                          ));
                }
              });
        });
  }

  _makePhoneCall(String url) {
    if (url != "null" ) {
      launch("tel:$url");
    } else {
      throw 'Telefone não informado';
    }
  }

  _makeEmailCall(String url) {
    if (url != "null") {
      launch("mailto:$url");
    } else {
      throw 'Email não informado';
    }
  }

  _testeNome(String nome) {
    if (nome == "null") {
      return " ";
    } else {
      return nome;
    }
  }

  _initialArea(String nome) {
    List<String> list = List.empty();
    String x, y, z, sig;

    list = nome.split(" ");
    if (list.length == 1) {
      sig = (list[0]).substring(0, 3);
      return sig;
    } else if (list.length == 2) {
      x = (list[0]).substring(0, 1);
      y = (list[1].substring(0, 1));
      sig = x + y;
      return sig;
    } else if (list.length == 3) {
      x = (list[0]).substring(0, 1);
      z = (list[2]).substring(0, 1);
      if (list[1].length > 2) {
        y = (list[1].substring(0, 1));
        sig = x + y + z;
        return sig;
      } else {
        sig = x + z;
        return sig;
      }
    } else if (list.length == 4) {
      if (list[0] == "BANCO" || list[0] == "BRADESCO") {
        sig = "BC";
        return sig;
      } else {
        x = (list[0]).substring(0, 1);
        z = (list[3]).substring(0, 1);
        if (list[1].length > 2) {
          y = (list[1].substring(0, 1));
        } else {
          y = (list[2].substring(0, 1));
        }
        sig = x + y + z;
        return sig;
      }
    } else if (list.length > 4) {
      x = (list[0]).substring(0, 1);
      z = (list[4]).substring(0, 1);
      if (list[1].length > 2) {
        y = (list[1].substring(0, 1));
      } else if (list[2].length > 2) {
        y = (list[2].substring(0, 1));
      } else {
        y = (list[3].substring(0, 1));
      }
      sig = x + y + z;
      return sig;
    }
  }
}