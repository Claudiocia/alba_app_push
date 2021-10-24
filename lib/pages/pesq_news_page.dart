import 'package:alba_app/models/autor_model.dart';
import 'package:alba_app/models/editoria_model.dart';
import 'package:alba_app/models/filtro_model.dart';
import 'package:alba_app/models/tipo_model.dart';
import 'package:alba_app/pages/noticias_pesq_page.dart';
import 'package:alba_app/pages/pauta_page.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../splashscreen.dart';

class PlacePesqNewsWidget extends StatefulWidget {
  PlacePesqNewsWidget();
  @override
  _PlacePesqNewsWidgetState createState() => _PlacePesqNewsWidgetState();
}

class _PlacePesqNewsWidgetState extends State<PlacePesqNewsWidget> {
  final _formKey = GlobalKey<FormState>();
  var _selectedEditoria;
  final _palavraFormController = TextEditingController();
  DateTime selectedDateIni;
  DateTime selectedDateFim;
  int editoria = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  setSelectedRadioTile(int val){
    setState(() {

    });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('pt')
      ],
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
                    builder: (context) => SplashScreenPage()));
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(
                        "Busca de Notícias",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                        "Informe pelo menos um parametro de busca",
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _palavraFormController,
                decoration: InputDecoration(
                  hintText: "digite o termo que deseja buscar em notícias",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF004a92),
                    onPrimary: Colors.white,
                    elevation: 30.0,
                  ),
                  child: Text(
                    "Data de inicio",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: (){
                    _selectDateIni(context);
                  },
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(
                        selectedDateIni != null ? "${selectedDateIni.day}/${selectedDateIni.month}/${selectedDateIni.year}" : ""
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF004a92),
                  onPrimary: Colors.white,
                  elevation: 30.0,
                ),
                child: Text(
                  "Data Fim",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: (){
                  _selectDateFim(context);
                },
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(
                        selectedDateFim != null ? "${selectedDateFim.day}/${selectedDateFim.month}/${selectedDateFim.year}" : ""
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(
                      "Editorias",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              DropdownButton<String>(
                hint: Text("Selecione"),
                value: _selectedEditoria,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (newValue){
                  setState(() {
                    editoria = EditoriaForForm.getEditoria(newValue);
                    _selectedEditoria = newValue;
                  });
                },
                items: EditoriaForForm.getEditString()
                    .map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 16.0,
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
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => PlacePesqNoticiaWidget(
                              editoria: editoria,
                              inicio: selectedDateIni,
                              fim: selectedDateFim,
                              palavra: _palavraFormController.text,
                            )));
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
  _selectDateIni(BuildContext context) async {
    final DateTime selectedIni = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
    );
    if(selectedIni != null && selectedIni != selectedDateIni)
      setState((){
        selectedDateIni = selectedIni;
      });
  }

  _selectDateFim(BuildContext context) async {
    final DateTime selectedFim = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if(selectedFim != null && selectedFim != selectedDateFim)
      setState((){
        selectedDateFim = selectedFim;
      });
  }
}