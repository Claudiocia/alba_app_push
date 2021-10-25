import 'package:alba_app/helpers/comissao_helper.dart';
import 'package:alba_app/models/comissao_model.dart';
import 'package:alba_app/pages/comissoes_page.dart';
import 'package:alba_app/pages/pesq_comissoes_page.dart';
import 'package:alba_app/utils/utilidades_gerais.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PlaceResultPesqComissWidget extends StatefulWidget {
  String valorPesq;
  PlaceResultPesqComissWidget({this.valorPesq});
  @override
  _PlaceResultPesqComissWidgetState createState() => _PlaceResultPesqComissWidgetState();
}

class _PlaceResultPesqComissWidgetState extends State<PlaceResultPesqComissWidget> {
  bool isLoading = false;
  ComissaoHelper helperComiss = ComissaoHelper();
  List<ComissaoModel> listComis = [];
  UtilidadeGeral utils = UtilidadeGeral();
  String tvNomeComiss, tvPresidComiss, tvViceComiss, tvTituComiss;
  String tvSupleComiss, tvDadosComiss, salaComiss, diaComiss, horaComiss;
  String pesq;
  String result;

  @override
  void initState() {
    isLoading = true;
    if(widget.valorPesq == null){
      setState(() {
        result = "Você precisa informar pelo menos um dado para a pesquisa";
        isLoading = false;
      });
    }else{
      pesq = utils.removeAcents(widget.valorPesq);
      helperComiss.getPesqAllComiss(pesq).then((list){
        setState(() {
          if(list != null){
            listComis = list;
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
                        builder: (context) => PlacePesqComissoesWidget()));
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "Recarregar",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PlaceComissoesWidget()));
              },
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: Container(
          child: listaComissoes(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaComissoes() {
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
      if(listComis.length == 0){
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
                          "Nenhum resultado encontrado! \n $result",
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
        return ListView.builder(
            itemCount: listComis.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5.0,
                        offset: Offset(2.0, 5.0),
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget> [
                          Text(
                            "Resultado da Busca",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      padding: EdgeInsets.only(
                          left: 5.0, top: 10.0, right: 5.0, bottom: 10.0),
                      width: 320.0,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Center(
                        child: Text(
                          listComis[index].nomeComiss + "\r\nTipo: " +
                              listComis[index].tipoComiss,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(25.0, 5.0, 5.0, 10.0),
                      child: Text(
                        "Presidente: Dep. "+ listComis[index].presComiss +
                            "\r\nVice: Dep. "+ listComis[index].viceComiss,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(25.0, 5.0, 5.0, 15.0),
                      child: Text(
                        "Titulares: \r\nDep. " +
                            (listComis[index].membrosComiss).replaceAll("/", ",\r\nDep. ") +
                            "\n\nSuplentes:\nDep. "+
                            (listComis[index].supleComiss).replaceAll("/", ",\r\nDep. ") +
                            "\n\nReuniões:\n" + listComis[index].localReunComiss +
                            "\nDia: " + listComis[index].diaReunComiss + " - Hora: " +
                            listComis[index].horaReunComiss + "\nTel.: (071) " +
                            listComis[index].telComiss + "\nCont.: " +
                            listComis[index].assessorComiss,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }
    }
  }
}