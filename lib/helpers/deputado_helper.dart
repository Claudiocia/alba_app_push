import 'package:alba_app/helpers/bd_plunge.dart';
import 'package:alba_app/models/deputado_model.dart';
import 'package:sqflite/sqflite.dart';


//nome das colunas
List<String> colsDep = [
  depIdCol, depNomeCol, depSexoCol, depPartCol, depGabCol, depTelCol,
  depEmailCol, depFotoCol, depLinkCol
];

class DeputadoHelper {

  DeputadoHelper();

  //Salvar novo
  Future<DeputadoModel> saveDep(DeputadoModel dep) async {
    Database dbDep = await BdPlunge.instance.dbAlba;
    dep.idDep = await dbDep.insert(tabDep, dep.toMap());

    return dep;
  }

  //buscar um registro
  Future<DeputadoModel> getDep(int id) async {
    Database dbDep = await BdPlunge.instance.dbAlba;

    List<Map> deps = await dbDep.query(tabDep, columns: colsDep,
        where: "$depIdCol = ?",
        whereArgs: [id]);
    if(deps.length > 0){
      return DeputadoModel.fromMap(deps.first);
    }else{
      return null;
    }
  }

  //buscar dep pelo nome
  Future<DeputadoModel> getDepNome(String nome) async {
    Database dbDep = await BdPlunge.instance.dbAlba;

    List<Map> deps = await dbDep.query(tabDep, columns: colsDep,
        where: "nomeDep = ?", whereArgs: [nome]);
    if(deps.length > 0){
      return DeputadoModel.fromMap(deps.first);
    }else{
      return null;
    }
  }

  //Deletar um registro
  Future<int> deleteDep(int id) async {
    Database dbDep = await BdPlunge.instance.dbAlba;
    return await dbDep.delete(tabDep, where: "$depIdCol = ?", whereArgs: [id]);
  }

  //Atualizar um registro
  Future<int> updateDep(DeputadoModel dep) async {
    Database dbDep = await BdPlunge.instance.dbAlba;
    return await dbDep.update(tabDep, dep.toMap(),
        where: "$depIdCol = ?", whereArgs: [dep.idDep]);
  }

  //buscar todos os registros
  Future<List> getAllDeps() async {
    Database dbDep = await BdPlunge.instance.dbAlba;
    List listMap = await dbDep.rawQuery("SELECT * FROM $tabDep ORDER BY $depNomeCol ASC");
    List<DeputadoModel> listDeps = [];
    for(Map m in listMap){
      listDeps.add(DeputadoModel.fromMap(m));
    }
    return listDeps;
  }

  //buscar quantidade total de registros
  Future<int> getNumber() async {
    Database dbDep = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(await dbDep.rawQuery("SELECT COUNT(*) FROM $tabDep"));
  }

  //Fechar o banco
  Future closeDb() async {
    Database dbDep = await BdPlunge.instance.dbAlba;
    dbDep.close();
  }
}