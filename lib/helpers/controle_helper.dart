


import 'package:alba_app/helpers/bd_plunge.dart';
import 'package:alba_app/models/controle_model.dart';
import 'package:sqflite/sqflite.dart';

class ControleHelper {

  ControleHelper();

  Future<ControleModel> saveControle(ControleModel controle) async {
    Database dbControle = await BdPlunge.instance.dbAlba;

    controle.idControle = await dbControle.insert(tabControle, controle.toMap());

    return controle;
  }

  Future<int> updateControle(Map control) async {
    Database dbControle = await BdPlunge.instance.dbAlba;
    ControleModel controle = ControleModel.fromMap(control);

    return await dbControle.update(tabControle, controle.toMap(),
        where: "$idControleCol = ?", whereArgs: [controle.idControle]);
  }

  Future<ControleModel> getControle() async {
    Database dbControle = await BdPlunge.instance.dbAlba;

    List<Map> controles = await dbControle.rawQuery("SELECT * FROM $tabControle ORDER BY $idControleCol DESC");

    if(controles.length > 0){
      return ControleModel.fromMap(controles.first);
    }else{
      return null;
    }

  }
}