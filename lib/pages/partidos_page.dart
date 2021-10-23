import 'package:alba_app/helpers/partido_helper.dart';
import 'package:alba_app/models/partido_model.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PlacePartidosWidget extends StatefulWidget {
  PlacePartidosWidget();

  @override
  _PlacePartidosWidgetState createState() => _PlacePartidosWidgetState();
}

class _PlacePartidosWidgetState extends State<PlacePartidosWidget> {
  PartidoHelper helperPart = PartidoHelper();
  List<PartidoModel> listPart = [];
  String lider, vice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helperPart.getAllPartidos().then((list) {
      setState(() {
        listPart = list;
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
        body: listaPartidos(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaPartidos() {
    return ListView.builder(
        itemCount: listPart.length,
        itemBuilder: (context, index) {
          if (listPart[index].vicePart == "null") {
            vice = "";
          } else {
            if (listPart[index].vicePart.contains("/")) {
              vice = "\r\nVice-Líderes: \r\nDep. " +
                  (listPart[index].vicePart).replaceAll("/", ", \r\nDep. ");
            } else {
              vice = "\r\nVice-Líder: \r\nDep. " + listPart[index].vicePart;
            }
          }
          if (listPart[index].liderPart == "null") {
            lider = "Partido com menos de 6 (seis) deputados na sua bancada.";
          } else {
            lider = "Líder: \r\nDep. " + listPart[index].liderPart + vice;
          }
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
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.only(
                      left: 5.0, top: 10.0, right: 5.0, bottom: 0.0),
                  width: 320.0,
                  height: 90.0,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Center(
                    child: Text(
                      listPart[index].nomePart +
                          "\n(" +
                          listPart[index].siglaPart +
                          ")",
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
                  padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                  child: Text(
                    lider +
                        "\n\nQtd.: " +
                        listPart[index].qtdBancada.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
