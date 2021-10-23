import 'package:alba_app/helpers/tododep_helper.dart';
import 'package:alba_app/models/tododep_model.dart';
import 'package:alba_app/pages/pesq_tododep_page.dart';
import 'package:alba_app/utils/utilidades_gerais.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PlaceTodosDepWidget extends StatefulWidget {
  String valorPesq;
  PlaceTodosDepWidget({this.valorPesq});
  @override
  _PlaceTodosDepWidgetState createState() => _PlaceTodosDepWidgetState();
}

class _PlaceTodosDepWidgetState extends State<PlaceTodosDepWidget> {
  bool isLoading = false;
  TodoDepHelper helperTodoDep = TodoDepHelper();
  List<TodoDepModel> listTodoDep = [];
  UtilidadeGeral utils = UtilidadeGeral();
  String pesq;
  String pathDep = "http://www.al.ba.gov.br/deputados/deputado-estadual/";
  String pathExDep = "http://www.al.ba.gov.br/deputados/ex-deputado-estadual/";

  @override
  void initState() {
    isLoading = true;
    if(widget.valorPesq == null){
      helperTodoDep.getAllTodosDeps().then((list){
        setState(() {
          listTodoDep = list;
          isLoading = false;
        });
      });
    }else{
      isLoading = true;
      pesq = utils.removeAcents(widget.valorPesq);
      helperTodoDep.getResultBusca(pesq).then((list){
        setState(() {
          if(list != null){
            listTodoDep = list;
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
                        builder: (context) => PlacePesqTodoDepWidget()));
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "Recarregar",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PlaceTodosDepWidget()));
              },
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: Container(
          child: listaTodosDeps(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaTodosDeps(){
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
    }else {
      if(listTodoDep.length == 0){
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
            padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 2.0),
            separatorBuilder: (context, index) => Divider(color: Colors.black54),
            itemCount: listTodoDep.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: Image.asset(
                    "assets/images/ic_marca_round.png",
                  ),
                ),
                title: Text(
                  listTodoDep[index].nomeParla,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  listTodoDep[index].nomeComple,
                  style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
                ),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(listTodoDep[index].nomeParla),
                        content: Text(
                            "Selecione a ação que você deseja!"
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: (){
                                if(listTodoDep[index].inMandat == 's'){
                                  _launchURL(pathDep + listTodoDep[index].linkPagin);
                                  Navigator.of(context).pop(true);
                                }else{
                                  _launchURL(pathExDep + listTodoDep[index].linkPagin);
                                  Navigator.of(context).pop(true);
                                }
                              },
                              child: Text('VISITAR A PÁGINA')),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(
                                  true),
                              child: Text('FECHAR'))
                        ],
                      )
                  );
                },
              );
            });
      }
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
