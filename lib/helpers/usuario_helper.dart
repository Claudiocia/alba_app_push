import 'package:alba_app/helpers/bd_plunge.dart';
import 'package:alba_app/models/usuario_model.dart';
import 'package:sqflite/sqflite.dart';

//nome das colunas
List<String> colsUser = [
  userIdCol, userNomeCol, userSexoCol, userEmailCol, userTeleCol, userRegidCol
];


class UsuarioHelper {

  UsuarioHelper();

  //Salvar novo usuario
  Future<UsuarioModel> saveUsuario(UsuarioModel user) async {

    Database dbUser = await BdPlunge.instance.dbAlba;
    user.idUser = await dbUser.insert(tabUser, user.toMap());

    return user;
  }

  //buscar um usuario
  Future<UsuarioModel> getUser() async {
    Database dbUser = await BdPlunge.instance.dbAlba;

    List<Map> users = await dbUser.query(tabUser,
        columns: colsUser);
    if(users.length > 0){
      return UsuarioModel.fromMap(users.first);
    }else{
      return null;
    }
  }

  //deletar um usuario
  Future<int> deleteUser(int id) async{
    Database dbUser = await BdPlunge.instance.dbAlba;
    return await dbUser.delete(tabUser, where: "$userIdCol = ?", whereArgs: [id]);
  }

  //Atualizar um usuario
  Future<int> updateUser(UsuarioModel user) async{
    Database dbUser = await BdPlunge.instance.dbAlba;
    return await dbUser.update(tabUser, user.toMap(),
        where: "$userIdCol = ?",
        whereArgs: [user.idUser]);
  }

  //Buscar Totos os usuarios
  Future<List> getAllUsers() async{
    Database dbUser = await BdPlunge.instance.dbAlba;
    List listMap = await dbUser.rawQuery("SELECT * FROM $tabUser");
    List<UsuarioModel> listUser = [];
    for(Map m in listMap){
      listUser.add(UsuarioModel.fromMap(m));
    }
    return listUser;
  }

  //Buscar qtos registros existem no banco
  Future<int> getNumber() async {
    Database dbUser = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(await dbUser.rawQuery("SELECT COUNT(*) FROM $tabUser"));
  }

  //Fechar o banco
  Future closeDb() async {
    Database dbUser = await BdPlunge.instance.dbAlba;
    dbUser.close();
  }
}