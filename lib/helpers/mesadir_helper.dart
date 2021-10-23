import 'package:alba_app/models/mesadir_model.dart';
import 'package:sqflite/sqflite.dart';

import 'bd_plunge.dart';

List<String> colsMesa = [
  mesaIdCol,
  mesaDepCol,
  mesaTelCol,
  mesaLocalCol,
  mesaCargoCol,
  mesaFotoCol,
  mesaPartCol
];

class MesaDirHelper {
  MesaDirHelper();

  //Salvar mesa
  Future<MesaDirModel> saveMesaDir(MesaDirModel mesa) async {
    Database dbMesa = await BdPlunge.instance.dbAlba;
    mesa.idMesa = await dbMesa.insert(tabMesadir, mesa.toMap());
    return mesa;
  }

  Future<MesaDirModel> getMesa(int id) async {
    Database dbMesa = await BdPlunge.instance.dbAlba;

    List<Map> mesas = await dbMesa.query(tabMesadir,
        columns: colsMesa, where: "$mesaIdCol = ?", whereArgs: [id]);
    if (mesas.length > 0) {
      return MesaDirModel.fromMap(mesas.first);
    } else {
      return null;
    }
  }

  Future<int> deleteMesa(int id) async {
    Database dbMesa = await BdPlunge.instance.dbAlba;
    return await dbMesa
        .delete(tabMesadir, where: "$mesaIdCol = ?", whereArgs: [id]);
  }

  Future<int> updateMesa(MesaDirModel mesa) async {
    Database dbMesa = await BdPlunge.instance.dbAlba;
    return await dbMesa.update(tabMesadir, mesa.toMap(),
        where: "$mesaIdCol = ?", whereArgs: [mesa.idMesa]);
  }

  Future<List> getAllMesa() async {
    Database dbMesa = await BdPlunge.instance.dbAlba;

    List listMap = await dbMesa.rawQuery("SELECT * FROM $tabMesadir");
    List<MesaDirModel> listMesas = [];
    for (Map m in listMap) {
      listMesas.add(MesaDirModel.fromMap(m));
    }

    return listMesas;
  }

  Future<int> getNumber() async {
    Database dbMesa = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(
        await dbMesa.rawQuery("SELECT COUNT (*) FROM $tabMesadir"));
  }

  Future closeDb() async {
    Database dbMesa = await BdPlunge.instance.dbAlba;
    dbMesa.close();
  }
}