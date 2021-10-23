import 'package:alba_app/pages/result_tel_page.dart';
import 'package:alba_app/pages/tel_page.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PlacePesqTelefonesWidget extends StatefulWidget {
  PlacePesqTelefonesWidget();
  @override
  _PlacePesqTelefonesWidgetState createState() => _PlacePesqTelefonesWidgetState();
}

class _PlacePesqTelefonesWidgetState extends State<PlacePesqTelefonesWidget> {
  final _formKey = GlobalKey<FormState>();
  final _numeroFormController = TextEditingController();

  @override
  // ignore: missing_return
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
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Text(
                "Digite um termo para efetuar a busca.",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _numeroFormController,
                decoration: InputDecoration(
                  hintText: "digite o nome a ser pesquisado",
                ),
              ),
              SizedBox(
                height: 44.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF004a92),
                    onPrimary: Colors.white,
                    elevation: 30.0,
                  ),
                  child: Text(
                    "Pesquisar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      //acionar a pag com navigator enviando as variaveis
                      String textoPesq = _numeroFormController.text;
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => PlaceResultPesqTelWidget(
                                  valorPesq: textoPesq)
                          )
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}