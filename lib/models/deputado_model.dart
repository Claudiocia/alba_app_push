import 'package:alba_app/helpers/bd_plunge.dart';

class DeputadoModel{

  int idDep;
  String nomeDep;
  String sexoDep;
  String partidoDep;
  String gabineteDep;
  String telefoneDep;
  String emailDep;
  String fotoDep;
  String linkDep;

  DeputadoModel();

  DeputadoModel.fromMap(Map map){
    idDep = map[depIdCol];
    nomeDep = map[depNomeCol];
    sexoDep = map[depSexoCol];
    partidoDep = map[depPartCol];
    gabineteDep = map[depGabCol];
    telefoneDep = map[depTelCol];
    emailDep = map[depEmailCol];
    fotoDep = map[depFotoCol];
    linkDep = map[depLinkCol];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      depNomeCol: nomeDep,
      depSexoCol: sexoDep,
      depPartCol: partidoDep,
      depGabCol: gabineteDep,
      depTelCol: telefoneDep,
      depEmailCol: emailDep,
      depFotoCol: fotoDep,
      depLinkCol: linkDep
    };
    if(idDep != null){
      map[depIdCol] = idDep;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Deputado: (id: $idDep, nome: $nomeDep, genero: $sexoDep, "
        "partido: $partidoDep, gab: $gabineteDep, tel: $telefoneDep, "
        "email: $emailDep, foto: $fotoDep, link: $linkDep";
  }


}