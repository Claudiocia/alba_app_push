import 'package:alba_app/helpers/bd_plunge.dart';

class ControleModel{
  int idControle;
  String versionAtual;
  String ultimaVerifc;
  String proximaVerifc;

  ControleModel();

  ControleModel.fromMap(Map map){
    idControle = map[idControleCol];
    versionAtual = map[versionAtualCol];
    ultimaVerifc = map[ultimaVerifcCol];
    proximaVerifc = map[proximaVerifcCol];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      versionAtualCol: versionAtual,
      ultimaVerifcCol: ultimaVerifc,
      proximaVerifcCol: proximaVerifc
    };
    if(idControle != null){
      map[idControleCol] = idControle;
    }
    return map;
  }
}

