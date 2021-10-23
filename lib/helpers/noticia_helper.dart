import 'package:alba_app/models/noticia_model.dart';
import 'package:sqflite/sqflite.dart';

import 'bd_plunge.dart';


List<String> colsNoti = [
  notiIdCol, notiTitCol, notiDataCol, notiResumCol, notiLinkCol, notiFotoCol, notiTimeCol
];

class NoticiaHelper {

  NoticiaHelper();

  Future<NoticiaModel> saveNoticia(NoticiaModel noti) async {
    Database dbNoti = await BdPlunge.instance.dbAlba;
    noti.idNoticia = await dbNoti.insert(tabNoticias, noti.toMap());

    return noti;
  }

  Future<NoticiaModel> getNoticia(int id) async {
    Database dbNoti = await BdPlunge.instance.dbAlba;

    List<Map> notis = await dbNoti.query(tabNoticias, columns: colsNoti,
        where: "$notiIdCol = ?", whereArgs: [id]);
    if(notis.length > 0){
      return NoticiaModel.fromMap(notis.first);
    }else{
      return null;
    }
  }

  Future<NoticiaModel> getNotiExist(NoticiaModel noti) async {
    Database dbNoti = await BdPlunge.instance.dbAlba;

    List<Map> notis = await dbNoti.query(tabNoticias, columns: colsNoti,
        where: "$notiLinkCol = ?", whereArgs: [noti.linkNoticia]);
    if(notis.length > 0){
      return NoticiaModel.fromMap(notis.first);
    }else{
      return null;
    }
  }

  Future<int> deleteNoti(int id) async {
    Database dbNoti = await BdPlunge.instance.dbAlba;
    return await dbNoti.delete(tabNoticias, where: "$notiIdCol = ?", whereArgs: [id]);
  }

  Future<int> deleteNotiPrazo() async {
    Database dbNoti = await BdPlunge.instance.dbAlba;
    var hoje = DateTime.now();
    var dia30 = hoje.add(new Duration(days: -30));

    return await dbNoti.delete(tabNoticias, where: "$notiTimeCol < ?", whereArgs: [dia30.toString()]);
  }

  Future<int> updateNoti(NoticiaModel noti) async {
    Database dbNoti = await BdPlunge.instance.dbAlba;
    return await dbNoti.update(tabNoticias, noti.toMap(),
        where: "$notiIdCol = ?", whereArgs: [noti.idNoticia]);
  }

  Future<List> getAllNoticias() async {
    Database dbNoti = await BdPlunge.instance.dbAlba;
    List listMap = await dbNoti.rawQuery(
        "SELECT * FROM $tabNoticias ORDER BY $notiLinkCol DESC");
    List<NoticiaModel> listNotis = [];
    for(Map m in listMap){
      listNotis.add(NoticiaModel.fromMap(m));
    }
    return listNotis;
  }

  Future<int> getNumber() async {
    Database dbNoti = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(await dbNoti.rawQuery("SELECT COUNT(*) FROM $tabNoticias"));
  }

  Future closeDb() async {
    Database dbNoti = await BdPlunge.instance.dbAlba;
    dbNoti.close();
  }
}