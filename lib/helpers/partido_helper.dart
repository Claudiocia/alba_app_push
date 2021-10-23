import 'package:alba_app/models/partido_model.dart';
import 'package:sqflite/sqflite.dart';

import 'bd_plunge.dart';

List<String> colsPart = [
  partIdCol, partTipoCol, partNomeCol, partSiglaCol, partLiderCol,
  partViceCol, partQtdCol
];

class PartidoHelper {

  PartidoHelper();

  Future<PartidoModel> savePartido(PartidoModel part) async {
    Database dbPart = await BdPlunge.instance.dbAlba;

    part.idPart = await dbPart.insert(tabPart, part.toMap());

    return part;
  }

  Future<int> deletePartido(int id) async {
    Database dbPart = await BdPlunge.instance.dbAlba;
    return await dbPart.delete(tabPart, where: "$partIdCol = ?", whereArgs: [id]);
  }

  Future<int> updatePartido(PartidoModel part) async {
    Database dbPart = await BdPlunge.instance.dbAlba;
    return await dbPart.update(tabPart, part.toMap(),
        where: "$partIdCol = ?", whereArgs: [part.idPart]);
  }

  Future<List> getAllPartidos() async {
    Database dbPart = await BdPlunge.instance.dbAlba;
    List listMap = await dbPart.rawQuery("SELECT * FROM $tabPart");
    List<PartidoModel> listParts = [];
    for(Map m in listMap){
      listParts.add(PartidoModel.fromMap(m));
    }
    return listParts;
  }

  Future<int> getNumber() async {
    Database dbPart = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(await dbPart.rawQuery("SELECT COUNT (*) FROM $tabPart"));
  }

  Future closeDb() async {
    Database dbPart = await BdPlunge.instance.dbAlba;
    dbPart.close();
  }
}