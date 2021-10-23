


import 'package:alba_app/helpers/bd_plunge.dart';

class ComissaoModel {

  int idComiss;
  String nomeComiss;
  String tipoComiss;
  String telComiss;
  String localReunComiss;
  String diaReunComiss;
  String horaReunComiss;
  String presComiss;
  String viceComiss;
  String membrosComiss;
  String supleComiss;
  String assessorComiss;

  ComissaoModel();

  ComissaoModel.fromMap(Map map){

    idComiss = map[comissIdCol];
    nomeComiss = map[comissNomeCol];
    tipoComiss = map[comissTipoCol];
    telComiss = map[comissTelCol];
    localReunComiss = map[comissLocCol];
    diaReunComiss = map[comissDiaCol];
    horaReunComiss = map[comissHoraCol];
    presComiss = map[comissPresCol];
    viceComiss = map[comissViceCol];
    membrosComiss = map[comissMembCol];
    supleComiss = map[comissSupleCol];
    assessorComiss = map[comissAsseCol];
  }

  Map toMap(){
    Map<String, dynamic> map ={
      comissNomeCol: nomeComiss,
      comissTipoCol: tipoComiss,
      comissTelCol: telComiss,
      comissLocCol: localReunComiss,
      comissDiaCol: diaReunComiss,
      comissHoraCol: horaReunComiss,
      comissPresCol: presComiss,
      comissViceCol: viceComiss,
      comissMembCol: membrosComiss,
      comissSupleCol: supleComiss,
      comissAsseCol: assessorComiss
    };
    if(idComiss != null){
      map[comissIdCol] = idComiss;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Comissão(id: $idComiss, nome: $nomeComiss, tipo: $tipoComiss, "
        "tel: $telComiss, localReu: $localReunComiss, diaReu: $diaReunComiss, "
        "horaReu: $horaReunComiss, pres: $presComiss, vice: $viceComiss, "
        "membrosTit: $membrosComiss, suple: $supleComiss, ass: $assessorComiss)";
  }

}