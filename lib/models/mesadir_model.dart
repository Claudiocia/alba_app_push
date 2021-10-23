import 'package:alba_app/helpers/bd_plunge.dart';


class MesaDirModel {
  int idMesa;
  String depMesa;
  String telMesa;
  String localMesa;
  String cargoMesa;
  String fotoDepMesa;
  String partDepMesa;

  MesaDirModel();

  MesaDirModel.fromMap(Map map){
    idMesa = map[mesaIdCol];
    depMesa = map[mesaDepCol];
    telMesa = map[mesaTelCol];
    localMesa = map[mesaLocalCol];
    cargoMesa = map[mesaCargoCol];
    fotoDepMesa = map[mesaFotoCol];
    partDepMesa = map[mesaPartCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      mesaDepCol: depMesa,
      mesaTelCol: telMesa,
      mesaLocalCol: localMesa,
      mesaCargoCol: cargoMesa,
      mesaFotoCol: fotoDepMesa,
      mesaPartCol: partDepMesa,
    };
    if(idMesa != null){
      map[mesaIdCol] = idMesa;

    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nMesa Diretora(id: $idMesa, \ndep: $depMesa, \ntel: $telMesa, "
        "\nlocal: $localMesa, \ncargo: $cargoMesa, \nfoto: $fotoDepMesa, \npart: $partDepMesa";
  }


}