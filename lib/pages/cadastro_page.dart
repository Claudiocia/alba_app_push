import 'package:alba_app/helpers/usuario_helper.dart';
import 'package:alba_app/models/usuario_model.dart';
import 'package:alba_app/pages/princ_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PlaceCadastroWidget extends StatefulWidget {
  PlaceCadastroWidget();
  @override
  _PlaceCadastroWidgetState createState() => _PlaceCadastroWidgetState();
}

class _PlaceCadastroWidgetState extends State<PlaceCadastroWidget> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  UsuarioModel user = UsuarioModel();
  UsuarioModel userLogado = UsuarioModel();
  UsuarioHelper userHelper = UsuarioHelper();

  final _nomeFormController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userHelper.getUser().then((value){
      if(value != null){
        userLogado = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dosis'),
      title: "ALBA APP",
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset(
            "assets/images/marca_mobi.png",
            width: 100.0,
          ),
        ),
        body: ScopedModelDescendant<UsuarioModel>(
          builder: (context, child, model){
            if(model.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/marca_alba_s.jpg",
                      width: 200.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              );
            }else {
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    Text("Informe o nome que você quer ser chamado no App"),
                    TextFormField(
                      controller: _nomeFormController,
                      decoration: InputDecoration(
                        hintText: "Nome",
                      ),
                      keyboardType: TextInputType.text,
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
                          "Informar",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "userNome": _nomeFormController.text,
                              "userSexo": null,
                              "userEmail": null,
                              "userTel": null,
                              "regid": "1",
                            };
                            model.cadastrarUser(
                                userData: userData,
                                onSucess: _onSucess,
                                onFail: _onFail
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void _onSucess(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registro salvo com sucesso!!",
          style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
          backgroundColor: Color(0xFF004a92),
          duration: Duration(seconds: 4),
        )
    );
    Navigator.of(context).pop();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PrincPage()));
  }

  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registro falhou!!",
          style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        )
    );

  }
}