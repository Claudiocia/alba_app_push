import 'package:alba_app/helpers/bd_plunge.dart';

class TodoDepModel{
  int idTodoDep;
  String nomeParla;
  String nomeComple;
  String linkPagin;
  String inMandat;
  String tag;

  TodoDepModel();

  TodoDepModel.fromMap(Map map){
    idTodoDep = map[idTodoDepCol];
    nomeParla = map[nomeParlaCol];
    nomeComple = map[nomeCompleCol];
    linkPagin = map[linkPaginCol];
    inMandat = map[inMandatCol];
    tag = map[tagCol];
  }

  Map toMap(){
    Map<String, dynamic> map = {
    nomeParlaCol: nomeParla,
    nomeCompleCol: nomeComple,
    linkPaginCol: linkPagin,
    inMandatCol: inMandat,
      tagCol: tag,
    };
    if(idTodoDep != null){
      map[idTodoDepCol] = idTodoDep;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nDep. $nomeParla, \nNome Completo: $nomeComple, \nNo Exerc: $inMandat, \nLink: $linkPagin";
  }

}