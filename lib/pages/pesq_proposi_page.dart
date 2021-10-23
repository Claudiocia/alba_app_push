import 'package:alba_app/models/autor_model.dart';
import 'package:alba_app/models/filtro_model.dart';
import 'package:alba_app/models/tipo_model.dart';
import 'package:alba_app/pages/pauta_page.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PlacePesqProposiWidget extends StatefulWidget {
  PlacePesqProposiWidget();
  @override
  _PlacePesqProposiWidgetState createState() => _PlacePesqProposiWidgetState();
}

class _PlacePesqProposiWidgetState extends State<PlacePesqProposiWidget> {
  final _formKey = GlobalKey<FormState>();
  var _selectedFiltro;
  var _selectedTipo;
  var _selectedAutor;
  final _numeroFormController = TextEditingController();
  int filtro = 0;
  String valor;
  String tipo;
  int autor;
  int selectedRadioTile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadioTile = 2;
  }

  setSelectedRadioTile(int val){
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if(filtro == 0) {
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
                      builder: (context) => PlacePautaWidget()));
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
                RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text("Proposições antigas"),
                    subtitle: Text("Selecione para antes de 19/01/2021"),
                    onChanged: (val){
                      setSelectedRadioTile(val);
                    },
                  activeColor: Color(0xFF004a92),
                  selected: false,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: selectedRadioTile,
                  title: Text("Proposições Novas"),
                  subtitle: Text("Selecione para depois de 19/01/2021"),
                  onChanged: (val){
                    setSelectedRadioTile(val);
                  },
                  activeColor: Color(0xFF004a92),
                  selected: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Divider(
                  height: 20,
                  color: Colors.red,
                ),
                Text(
                  "Selecione o filtro para a busca",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  hint: Text("Selecione"),
                  value: _selectedFiltro,
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
                  onChanged: (newValue) {
                    setState(() {
                      filtro = FiltroForForm.getFiltros(newValue);
                      _selectedFiltro = newValue;
                      _numeroFormController.clear();
                    });
                  },
                  items: FiltroForForm.getFiltString()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
      );
    }else if(filtro == 1){
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
                      builder: (context) => PlacePautaWidget()));
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
                RadioListTile(
                  value: 1,
                  groupValue: selectedRadioTile,
                  title: Text("Proposições antigas"),
                  subtitle: Text("Selecione para antes de 19/01/2021"),
                  onChanged: (val){
                    setSelectedRadioTile(val);
                  },
                  activeColor: Color(0xFF004a92),
                  selected: false,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: selectedRadioTile,
                  title: Text("Proposições Novas"),
                  subtitle: Text("Selecione para depois de 19/01/2021"),
                  onChanged: (val){
                    setSelectedRadioTile(val);
                  },
                  activeColor: Color(0xFF004a92),
                  selected: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Divider(
                  height: 20,
                  color: Colors.red,
                ),
                Text(
                  "Selecione o filtro para a busca",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  hint: Text("Selecione"),
                  value: _selectedFiltro,
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
                  onChanged: (newValue) {
                    setState(() {
                      filtro = FiltroForForm.getFiltros(newValue);
                      _selectedFiltro = newValue;
                      _numeroFormController.clear();
                    });
                  },
                  items: FiltroForForm.getFiltString()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _numeroFormController,
                  decoration: InputDecoration(
                    hintText: "Numero no formato n.nnn/aa ou nnnn/aaaa",
                  ),
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
                      if(filtro != 1){
                        //mostrar um snack com mensagem de erro
                      }else {
                        if(_formKey.currentState.validate()){
                          //acionar a pag com navigator enviando as variaveis
                          String textoPesq = _numeroFormController.text;
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => PlacePautaWidget(
                                      filtroPesq: filtro,
                                      valorPesq: textoPesq,
                                      bancoPesq: selectedRadioTile)));
                        }
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
    }else if(filtro == 2){
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
                      builder: (context) => PlacePautaWidget()));
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
                RadioListTile(
                  value: 1,
                  groupValue: selectedRadioTile,
                  title: Text("Proposições antigas"),
                  subtitle: Text("Selecione para antes de 19/01/2021"),
                  onChanged: (val){
                    setSelectedRadioTile(val);
                  },
                  activeColor: Color(0xFF004a92),
                  selected: false,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: selectedRadioTile,
                  title: Text("Proposições Novas"),
                  subtitle: Text("Selecione para depois de 19/01/2021"),
                  onChanged: (val){
                    setSelectedRadioTile(val);
                  },
                  activeColor: Color(0xFF004a92),
                  selected: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Divider(
                  height: 20,
                  color: Colors.red,
                ),
                Text(
                  "Selecione o filtro para a busca",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  hint: Text("Selecione"),
                  value: _selectedFiltro,
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
                  onChanged: (newValue) {
                    setState(() {
                      filtro = FiltroForForm.getFiltros(newValue);
                      _selectedFiltro = newValue;
                      _numeroFormController.clear();
                    });
                  },
                  items: FiltroForForm.getFiltString()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Selecione o tipo de proposição",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  hint: Text("Selecione o tipo"),
                  value: _selectedTipo,
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
                  onChanged: (newTipo){
                    setState(() {
                      tipo = newTipo;
                      _selectedTipo = newTipo;
                    });
                  },
                  items: TipoForForm.getTipo()
                      .map<DropdownMenuItem<String>>((String tipo){
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
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
                      if(filtro != 2){
                        //mostrar um snack com mensagem de erro
                      }else{
                        //acionar a pag com navigator enviando as variaveis
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => PlacePautaWidget(
                                    filtroPesq: filtro,
                                    valorPesq: tipo,
                                    bancoPesq: selectedRadioTile)));
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
    }else if (filtro == 3){
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
                      builder: (context) => PlacePautaWidget()));
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
                RadioListTile(
                  value: 1,
                  groupValue: selectedRadioTile,
                  title: Text("Proposições antigas"),
                  subtitle: Text("Selecione para antes de 19/01/2021"),
                  onChanged: (val){
                    setSelectedRadioTile(val);
                  },
                  activeColor: Color(0xFF004a92),
                  selected: false,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: selectedRadioTile,
                  title: Text("Proposições Novas"),
                  subtitle: Text("Selecione para depois de 19/01/2021"),
                  onChanged: (val){
                    setSelectedRadioTile(val);
                  },
                  activeColor: Color(0xFF004a92),
                  selected: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Divider(
                  height: 20,
                  color: Colors.red,
                ),
                Text(
                  "Selecione o filtro para a busca",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  hint: Text("Selecione"),
                  value: _selectedFiltro,
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
                  onChanged: (newValue) {
                    setState(() {
                      filtro = FiltroForForm.getFiltros(newValue);
                      _selectedFiltro = newValue;
                      _numeroFormController.clear();
                    });
                  },
                  items: FiltroForForm.getFiltString()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Selecione o autor da proposição",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  hint: Text("Selecione o autor"),
                  value: _selectedAutor,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (newAutor){
                    setState(() {
                      autor = AutorForForm.getAutor(newAutor);
                      _selectedAutor = newAutor;
                    });
                  },
                  items: AutorForForm.getAutorString().map<DropdownMenuItem<String>>((String autor){
                    return DropdownMenuItem<String>(
                      value: autor,
                      child: Text(autor),
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
                      if(filtro != 3){
                        //mostrar um snack com mensagem de erro
                      }else{
                        //acionar a pag com navigator enviando as variaveis
                        String autorPesq = autor.toString();
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => PlacePautaWidget(
                                    filtroPesq: filtro,
                                    valorPesq: autorPesq,
                                  bancoPesq: selectedRadioTile)));
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
}