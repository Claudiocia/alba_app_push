

import 'package:alba_app/helpers/bd_plunge.dart';
import 'package:alba_app/models/comissao_model.dart';
import 'package:sqflite/sqflite.dart';


//nome das colunas
List<String> colsComiss = [
  comissIdCol, comissNomeCol, comissTipoCol, comissTelCol, comissLocCol,
  comissDiaCol, comissHoraCol, comissPresCol, comissViceCol,
  comissMembCol, comissSupleCol, comissAsseCol,
];

class ComissaoHelper {

  ComissaoHelper();

  //Criar novo Comissão
  Future<ComissaoModel> saveComissao(ComissaoModel comiss) async {

    Database dbComiss = await BdPlunge.instance.dbAlba;
    comiss.idComiss = await dbComiss.insert(tabComiss, comiss.toMap());

    return comiss;
  }

  Future<ComissaoModel> getComiss(int id) async {
    Database dbComiss = await BdPlunge.instance.dbAlba;

    List<Map> comissS = await dbComiss.query(tabComiss,
        columns: colsComiss,
        where: "$comissIdCol = ?",
        whereArgs: [id]);
    if(comissS.length > 0){
      return ComissaoModel.fromMap(comissS.first);
    }else{
      return null;
    }
  }

  Future<int> deleteComiss(int id) async {
    Database dbComiss = await BdPlunge.instance.dbAlba;
    return await dbComiss.delete(tabComiss,
        where: "$comissIdCol = ?", whereArgs: [id]);
  }

  Future<int> updateComiss(ComissaoModel comiss) async {
    Database dbComiss = await BdPlunge.instance.dbAlba;
    return await dbComiss.update(tabComiss, comiss.toMap(),
        where: "$comissIdCol = ?", whereArgs: [comiss.idComiss]);
  }

  Future<List> getAllComiss() async {
    Database dbComiss = await BdPlunge.instance.dbAlba;
    List listMap = await dbComiss.rawQuery("SELECT * FROM $tabComiss");
    List<ComissaoModel> listComiss = [];
    for(Map m in listMap){
      listComiss.add(ComissaoModel.fromMap(m));
    }
    return listComiss;
  }

  Future<int> getNumber() async {
    Database dbComiss = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(await dbComiss.rawQuery("SELECT COUNT (*) FROM $tabComiss"));
  }

  Future closeDb() async {
    Database dbComiss = await BdPlunge.instance.dbAlba;
    dbComiss.close();
  }
}