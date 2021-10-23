import 'package:alba_app/helpers/bd_plunge.dart';

class SetorModel {

  int idSetor;
  String areaSetor;
  String nomeSetor;
  String respSetor;
  String emailSetor;
  String telSetor;
  String tagSetor;

  SetorModel();

  SetorModel.fromMap(Map map){
    idSetor = map[setorIdCol];
    areaSetor = map[setorAreaCol];
    nomeSetor = map[setorNomeCol];
    respSetor = map[setorRespCol];
    emailSetor = map[setorEmailCol];
    telSetor = map[setorTelCol];
    tagSetor = map[setorTagCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      setorAreaCol: areaSetor,
      setorNomeCol: nomeSetor,
      setorRespCol: respSetor,
      setorEmailCol: emailSetor,
      setorTelCol: telSetor,
      setorTagCol: tagSetor
    };
    if(idSetor != null){
      map[setorIdCol] = idSetor;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nSetor(id: $idSetor, \narea: $areaSetor, \nnome: $nomeSetor, "
        "\n resp: $respSetor, \nemail: $emailSetor, \ntel: $telSetor)";
  }
}