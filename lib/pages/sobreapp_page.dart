import 'dart:ui';

import 'package:alba_app/helpers/mesadir_helper.dart';
import 'package:alba_app/models/mesadir_model.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PlaceSobreAppWidget extends StatefulWidget {
  PlaceSobreAppWidget();
  @override
  _PlaceSobreAppWidgetState createState() => _PlaceSobreAppWidgetState();
}

class _PlaceSobreAppWidgetState extends State<PlaceSobreAppWidget> {
  MesaDirHelper helperMesa = MesaDirHelper();
  List<MesaDirModel> listMesa = [];
  bool isLoading = false;

  final textParagrafo_1 = "Este aplicativo foi desenvolvido com o objetivo de ampliar a "
      "transparência e facilitar o acesso da população às informações disponibilizadas "
      "através dos canais oficiais da Assembleia Legislativa da Bahia. Desenvolvido e "
      "lançado na gestão do deputado Nelson Leal, este aplicativo representa a "
      "modernização do Legislativo baiano, com as tendências tecnológicas da atualidade.";

  final textParagrafo_2 = "Notícias, proposições em tramitação, acervo do AlbaCultural, "
      "lista de telefones e muitas outras informações ficam mais acessíveis a todos. "
      "Além disto, através de configurações específicas, o usuário poderá acompanhar o "
      "trabalho do seu deputado na Casa, participar dos debates, conhecer as proposições, "
      "homenagens e todas as demais atividades desenvolvidas pelos parlamentares, que buscam "
      "sempre o bem comum dos baianos.";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    helperMesa.getAllMesa().then((list){
      setState(() {
        listMesa = list;
        isLoading = false;
      });
    });
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
            width: 100.0,),
        ),
        drawer: CustomDrawer(),
        body: listaMesa(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaMesa(){
    if(isLoading){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
      );
    }else {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Sobre o APP",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/marca_alba_s.jpg",
                      width: 250.0,
                      alignment: Alignment.center,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      child: Text(textParagrafo_1,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      child: Text(textParagrafo_2,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Mesa Diretora",
                                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Dep. "+ listMesa[0].depMesa,
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Presidente",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[1].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("1º Vice-Presidente",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[2].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("2ª Vice-Presidente",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[3].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("3º Vice-Presidente",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[4].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("4º Vice-Presidente",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[5].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("1ª Secretária",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[6].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("2º Secretário",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[7].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("3ª Secretária",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Dep. "+ listMesa[8].depMesa,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(listMesa[8].cargoMesa,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(" _______________________ ",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF004a92)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Ivoneide Souza Caetano",
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Sup. de Assuntos Parlamentar",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Francisco Raposo",
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Sup. de Recursos Humanos",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Robson José Coutinho Sousa",
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Sup. de Administração e Finanças",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Paulo Bina",
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Assessoria de Comunicação Social",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
