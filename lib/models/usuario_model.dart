import 'package:alba_app/helpers/bd_plunge.dart';
import 'package:alba_app/helpers/usuario_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';


class UsuarioModel extends Model {

  int idUser;
  String nome;
  String sexo;
  String email;
  String telef;
  String regid;

  UsuarioModel();

  UsuarioModel userLogged;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;
  UsuarioHelper helperUser = UsuarioHelper();



  UsuarioModel.fromMap(Map map){
    idUser = map[userIdCol];
    nome = map[userNomeCol];
    sexo = map[userSexoCol];
    email = map[userEmailCol];
    telef = map[userTeleCol];
    regid = map[userRegidCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      userNomeCol: nome,
      userSexoCol: sexo,
      userEmailCol: email,
      userTeleCol: telef,
      userRegidCol: regid
    };
    if(idUser != null){
      map[userIdCol] = idUser;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nUsuário(id: $idUser, \nnome: $nome, \ngenero: $sexo, \nemail: $email, \ntel: $telef)";
  }

  void cadastrarUser({@required Map<String, dynamic> userData, @required VoidCallback onSucess, @required VoidCallback onFail}) async{
    isLoading =  true;
    notifyListeners();

    UsuarioModel user = UsuarioModel.fromMap(userData);

    helperUser.saveUsuario(user).then((user){
      onSucess();
      isLoading = false;
      notifyListeners();
    }). catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });

    isLoading = false;
    notifyListeners();
  }

  UsuarioModel verificUser() {
    isLoading = true;
    notifyListeners();

    List<Map> listUser = [];
    UsuarioModel user = new UsuarioModel();
    helperUser.getAllUsers().then((list){
      listUser = list;
    });

    if(listUser.length > 0){
      user = UsuarioModel.fromMap(listUser.first);
      notifyListeners();
      return user;
    }
    else{
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  UsuarioModel userLogado(){

    helperUser.getUser().then((usuario){
      userLogged = usuario;
    });

    if(userLogged != null){
      notifyListeners();
      return userLogged;
    }
    else {
      notifyListeners();
      return null;
    }

  }

}