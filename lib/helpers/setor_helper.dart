import 'package:alba_app/models/setor_model.dart';
import 'package:sqflite/sqflite.dart';

import 'bd_plunge.dart';

List<String> colsSetor = [
  setorIdCol, setorAreaCol, setorNomeCol,
  setorRespCol, setorEmailCol, setorTelCol,
  setorTagCol
];

class SetorHelper {

  SetorHelper();

  Future<SetorModel> saveSetor(SetorModel setor) async {
    Database dbSetor = await BdPlunge.instance.dbAlba;
    setor.idSetor = await dbSetor.insert(tabSetores, setor.toMap());

    return setor;
  }

  Future<SetorModel> getSetor(int id) async {
    Database dbSetor = await BdPlunge.instance.dbAlba;

    List<Map> maps = await dbSetor.query(tabSetores, columns: colsSetor,
        where: "$setorIdCol = ?", whereArgs: [id]);
    if(maps.length > 0){
      return SetorModel.fromMap(maps.first);
    }else {
      return null;
    }
  }

  Future<int> deleteSetor(int id) async {
    Database dbSetor = await BdPlunge.instance.dbAlba;
    return await dbSetor.delete(tabSetores, where: "$setorIdCol = ?", whereArgs: [id]);
  }

  Future<int> updateSetor(SetorModel setor) async {
    Database dbSetor = await BdPlunge.instance.dbAlba;
    return await dbSetor.update(tabSetores, setor.toMap(),
        where: "$setorIdCol = ?", whereArgs: [setor.idSetor]);
  }

  Future<List> getAllSetors() async {
    Database dbSetor = await BdPlunge.instance.dbAlba;
    List listMap = await dbSetor.rawQuery("SELECT * FROM $tabSetores");
    List<SetorModel> listSetors = [];
    for(Map m in listMap){
      listSetors.add(SetorModel.fromMap(m));
    }
    return listSetors;
  }

  Future<List> getResultBusca(String busca) async {
    Database dbSetor = await BdPlunge.instance.dbAlba;
    List listMaps = await dbSetor.rawQuery("SELECT * FROM $tabSetores "
        "WHERE $setorTagCol LIKE '%$busca%' ORDER BY $setorIdCol ASC");
    List<SetorModel> listResultBusca = [];
    if(listMaps.length > 0){
      for(Map m in listMaps){
        listResultBusca.add(SetorModel.fromMap(m));
      }
      return listResultBusca;
    }else{
      return null;
    }
  }

  Future<int> getNumber() async {
    Database dbSetor = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(await dbSetor.rawQuery("SELECT COUNT (*) FROM $tabSetores"));
  }

  Future closeDb() async {
    Database dbSetor = await BdPlunge.instance.dbAlba;
    dbSetor.close();
  }
}