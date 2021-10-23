import 'package:alba_app/helpers/setor_helper.dart';
import 'package:alba_app/models/setor_model.dart';
import 'package:alba_app/pages/pesq_telefones_page.dart';
import 'package:alba_app/pages/tel_page.dart';
import 'package:alba_app/utils/utilidades_gerais.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PlaceResultPesqTelWidget extends StatefulWidget {
  String valorPesq;
  PlaceResultPesqTelWidget({this.valorPesq});
  @override
  _PlaceResultPesqTelWidgetState createState() => _PlaceResultPesqTelWidgetState();
}

class _PlaceResultPesqTelWidgetState extends State<PlaceResultPesqTelWidget> {
  bool isLoading = false;
  SetorModel setor = SetorModel();
  SetorHelper helperSetor = SetorHelper();
  List<SetorModel> listSetors = List.empty();
  UtilidadeGeral utils = UtilidadeGeral();
  String pesq;

  @override
  void initState() {
    isLoading = true;
    if(widget.valorPesq == null){
      helperSetor.getAllSetors().then((list) {
        setState(() {
          listSetors = list;
          isLoading = false;
        });
      });
    }else{
      pesq = utils.removeAcents(widget.valorPesq);
      helperSetor.getResultBusca(pesq).then((list){
        setState(() {
          if(list != null){
            listSetors = list;
            isLoading = false;
          }else{
            isLoading = false;
          }
        });
      });
    }

    super.initState();
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "Pesquisar",
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PlacePesqTelefonesWidget()));
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "Recarregar",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TelPage()));
              },
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: Container(
          child: listaTelefones(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaTelefones() {
    if(isLoading){
      return SingleChildScrollView(
        child: Container(
          height: 600,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/marca_alba_s.jpg",
                  width: 200.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Carregando...",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }else{
      if(listSetors.length == 0){
        return SingleChildScrollView(
          child: Center(
            child: Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/marca_alba_s.jpg",
                    width: 200.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Nenhum resultado encontrado!",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }else{
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
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  title: Text(
                    listSetors[index].areaSetor,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(listSetors[index].nomeSetor +
                      "\n" +
                      _testeNome(listSetors[index].respSetor) +
                      "\n" +
                      listSetors[index].telSetor),
                  onTap: () {
                    if(listSetors[index].emailSetor == "null"){
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(listSetors[index].nomeSetor),
                            content: Text(listSetors[index].respSetor +
                                "\nEmail: " +
                                listSetors[index].emailSetor +
                                "\nTel.: (071)" +
                                listSetors[index].telSetor),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: null,
                                  child: Text('Enviar email')),
                              TextButton(
                                  onPressed: () {
                                    _makePhoneCall("071" + (listSetors[index].telSetor).substring(0, 9));
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('LIGAR')),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(
                                      true),
                                  child: Text('FECHAR'))
                            ],
                          )
                      );
                    }else {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: Text(listSetors[index].nomeSetor),
                                content: Text(listSetors[index].respSetor +
                                    "\nEmail: " +
                                    listSetors[index].emailSetor +
                                    "\nTel.: (071)" +
                                    listSetors[index].telSetor),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        _makeEmailCall(listSetors[index]
                                            .emailSetor);
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Enviar email')),
                                 TextButton(
                                      onPressed: () {
                                        _makePhoneCall("071" +
                                            (listSetors[index].telSetor).substring(
                                                0, 9));
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('LIGAR')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(
                                              true),
                                      child: Text('FECHAR'))
                                ],
                              ));
                    }
                  });
            });
      }
    }
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