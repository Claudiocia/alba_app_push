import 'package:alba_app/models/proposicao_model.dart';
import 'package:alba_app/pages/pesq_proposi_page.dart';
import 'package:alba_app/utils/propos_api.dart';
import 'package:alba_app/utils/utilidades_gerais.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PlacePautaWidget extends StatefulWidget {
  int filtroPesq;
  String valorPesq;
  int bancoPesq;
  PlacePautaWidget({this.filtroPesq, this.valorPesq, this.bancoPesq});
  @override
  _PlacePautaWidgetState createState() => _PlacePautaWidgetState();
}

class _PlacePautaWidgetState extends State<PlacePautaWidget> {
  PropositionApi proposiApi = PropositionApi();
  List<ProposicaoModel> listProposi = [];
  UtilidadeGeral utils = UtilidadeGeral();
  ProposicaoModel proposicao;
  bool isLoading = false;
  var filtro;
  String valor;
  String tipo = "PL.";

  //Variaveis para o form de pesquisa
  String selected;

  @override
  void initState() {
    isLoading = true;
    if(widget.filtroPesq == null ) {
      proposiApi.loadProposic().then((value) {
        setState(() {
          if(value != null){
            listProposi = value;
            isLoading = false;
          }else{
            isLoading = false;
          }
        });
      });
    }else{
      proposiApi.loadProposic(filtro: widget.filtroPesq, valor: widget.valorPesq, bancoPesq: widget.bancoPesq).then((value) {
        setState(() {
          if(value != null){
            listProposi = value;
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
          title: Image.asset(
            "assets/images/marca_mobi.png",
            width: 100.0,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "Pesquisar",
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PlacePesqProposiWidget()));
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "Recarregar",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PlacePautaWidget()));
              },
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: listaProposi(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaProposi(){
    if (isLoading) {
      return Center(
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
      );
    }else if(listProposi.length > 0){
      return ListView.separated(
        padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        separatorBuilder: (context, index) => Divider(color: Colors.black54),
        itemCount: listProposi.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: utils.gerarColor(),
              foregroundColor: Colors.white,
              child: Icon(
                Icons.insert_drive_file,
                color: Colors.white,
              ),
            ),
            title: Text(
              listProposi[index].numerProposi,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              listProposi[index].ementProposi,
              style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            ),
            onTap: (){
              _launchURL(listProposi[index].linkProposi);
            },
          );
        },
      );
    }else{
      return Center(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Busca sem resultados!",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  _launchURL(String urlNew) async {
    var url = urlNew;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
