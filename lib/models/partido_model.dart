import 'package:alba_app/helpers/bd_plunge.dart';

class PartidoModel {
  int idPart;
  String tipoPart;
  String nomePart;
  String siglaPart;
  String liderPart;
  String vicePart;
  int qtdBancada;

  PartidoModel();

  PartidoModel.fromMap(Map map){
    idPart = map[partIdCol];
    tipoPart = map[partTipoCol];
    nomePart = map[partNomeCol];
    siglaPart = map[partSiglaCol];
    liderPart = map[partLiderCol];
    vicePart = map[partViceCol];
    qtdBancada = map[partQtdCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      partTipoCol: tipoPart,
      partNomeCol: nomePart,
      partSiglaCol: siglaPart,
      partLiderCol: liderPart,
      partViceCol: vicePart,
      partQtdCol: qtdBancada,
    };
    if(idPart != null){
      map[partIdCol] = idPart;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nPartidos(id: $idPart, \ntipo: $tipoPart, \nnome: $nomePart, "
        "\nsigla: $siglaPart, \nlider: $liderPart, \nvice: $vicePart, "
        "\nqtd: $qtdBancada)";
  }

}