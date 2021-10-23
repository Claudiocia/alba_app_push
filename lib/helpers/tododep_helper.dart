
import 'package:alba_app/helpers/bd_plunge.dart';
import 'package:alba_app/models/tododep_model.dart';
import 'package:sqflite/sqflite.dart';

List<String> colsTodoDep = [
  idTodoDepCol, nomeParlaCol, nomeCompleCol, linkPaginCol, inMandatCol, tagCol
];


class TodoDepHelper{
  TodoDepHelper();

  Future<TodoDepModel> saveTodoDep(TodoDepModel todoDep) async {
    Database dbTodoDep = await BdPlunge.instance.dbAlba;
    todoDep.idTodoDep = await dbTodoDep.insert(tabTodosDep, todoDep.toMap());

    return todoDep;
  }

  Future<TodoDepModel> getTodoDep(int id) async {
    Database dbTodoDep = await BdPlunge.instance.dbAlba;

    List<Map> maps = await dbTodoDep.query(tabTodosDep, columns: colsTodoDep,
      where: "$idTodoDepCol = ?", whereArgs: [id]);

    if(maps.length > 0){
      return TodoDepModel.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> updateTodoDep(TodoDepModel todoDep) async {
    Database dbTodoDep = await BdPlunge.instance.dbAlba;
    return await dbTodoDep.update(tabTodosDep, todoDep.toMap(),
        where: "$idTodoDepCol = ?", whereArgs: [todoDep.idTodoDep]);
  }

  Future<List> getAllTodosDeps() async {
    Database dbTodoDep = await BdPlunge.instance.dbAlba;
    List listMap = await dbTodoDep.rawQuery("SELECT * FROM $tabTodosDep");
    List<TodoDepModel> listTodosDeps = [];
    for(Map m in listMap){
      listTodosDeps.add(TodoDepModel.fromMap(m));
    }
    return listTodosDeps;
  }

  Future<List> getResultBusca(String busca) async {
    Database dbTodoDep = await BdPlunge.instance.dbAlba;
    List listMaps = await dbTodoDep.rawQuery("SELECT * FROM $tabTodosDep "
        "WHERE $tagCol LIKE '%$busca%' ORDER BY $nomeParlaCol ASC");
    List<TodoDepModel> listResultBusca = [];
    if(listMaps.length > 0) {
      for(Map m in listMaps){
        listResultBusca.add(TodoDepModel.fromMap(m));
      }
      return listResultBusca;
    }else {
      return null;
    }
  }

  Future<int> getNumber() async {
    Database dbTodoDep = await BdPlunge.instance.dbAlba;

    return Sqflite.firstIntValue(await dbTodoDep.rawQuery("SELECT COUNT (*) FROM $tabTodosDep"));
  }

  Future closeDb() async {
    Database dbTodoDep = await BdPlunge.instance.dbAlba;
    dbTodoDep.close();
  }

}