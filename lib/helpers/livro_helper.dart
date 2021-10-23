import 'package:alba_app/models/livro_model.dart';
import 'package:sqflite/sqflite.dart';

import 'bd_plunge.dart';

List<String> colsLivro = [
  idLivroCol, titLivroCol, linkLivroCol, capaLivroCol, edtLivroCol, autorLivroCol,
  publicLivroCol, formatLivroCol, resumLivroCol, isbnLivroCol, fonteLivroCol,
  dataBancoCol, numPagCol
];

class LivroHelper {

  LivroHelper();

  Future<LivroModel> saveLivro(LivroModel livro) async {
    Database dbLivro = await BdPlunge.instance.dbAlba;
    livro.idLivro = await dbLivro.insert(tabLivros, livro.toMap());

    return livro;
  }


  Future<LivroModel> getLivro(int id) async {
    Database dbLivro = await BdPlunge.instance.dbAlba;

    List<Map> livros = await dbLivro.query(tabLivros, columns: colsLivro,
        where: "$idLivroCol = ?", whereArgs: [id]);
    if(livros.length > 0){
      return LivroModel.fromMap(livros.first);
    }else{
      return null;
    }
  }

  Future<List> getAllLivros() async{
    Database dbLivro = await BdPlunge.instance.dbAlba;

    List listMap = await dbLivro.rawQuery(
        "SELECT * FROM $tabLivros ORDER BY $dataBancoCol DESC");
    List<LivroModel> listLivos = [];
    for(Map m in listMap){
      listLivos.add(LivroModel.fromMap(m));
    }
    return listLivos;
  }

  Future<int> getNumber() async{
    Database dbLivro = await BdPlunge.instance.dbAlba;
    return Sqflite.firstIntValue(await dbLivro.rawQuery("SELECT COUNT(*) FROM $tabLivros"));
  }

  Future<int> getNumberPag() async{
    int n = 0;
    Database dbLivro = await BdPlunge.instance.dbAlba;
    List listMap = await dbLivro.rawQuery("SELECT $numPagCol FROM $tabLivros");

    if(listMap.length > 0){
      n = listMap.length;
    }
    return n;
  }

  Future<int> deleteTabela() async {
    Database dbLivro = await BdPlunge.instance.dbAlba;
    return await dbLivro.delete(tabLivros);
  }


  Future closeDb() async {
    Database dbLivro = await BdPlunge.instance.dbAlba;
    dbLivro.close();
  }

}