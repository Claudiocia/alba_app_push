import 'package:alba_app/pages/todosdep_page.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PlacePesqTodoDepWidget extends StatefulWidget {
  PlacePesqTodoDepWidget();
  @override
  _PlacePesqTodoDepWidgetState createState() => _PlacePesqTodoDepWidgetState();
}

class _PlacePesqTodoDepWidgetState extends State<PlacePesqTodoDepWidget> {
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
                    builder: (context) => PlaceTodosDepWidget()));
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
                "Digite um nome para efetuar a busca.",
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      //acionar a pag com navigator enviando as variaveis
                      String textoPesq = _numeroFormController.text;
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => PlaceTodosDepWidget(
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