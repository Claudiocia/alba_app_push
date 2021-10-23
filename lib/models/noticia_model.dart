import 'package:alba_app/helpers/bd_plunge.dart';

class NoticiaModel {
  int idNoticia;
  String titleNoticia;
  String dataNoticia;
  String resumoNoticia;
  String linkNoticia;
  String fotoNoticia;
  String timestampNoti;

  NoticiaModel();

  NoticiaModel.fromMap(Map map){
    idNoticia = map[notiIdCol];
    titleNoticia = map[notiTitCol];
    dataNoticia = map[notiDataCol];
    resumoNoticia = map[notiResumCol];
    linkNoticia = map[notiLinkCol];
    fotoNoticia = map[notiFotoCol];
    timestampNoti = map[notiTimeCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      notiTitCol: titleNoticia,
      notiDataCol: dataNoticia,
      notiResumCol: resumoNoticia,
      notiLinkCol: linkNoticia,
      notiFotoCol: fotoNoticia
    };
    if(idNoticia != null){
      map[notiIdCol] = idNoticia;
      map[notiTimeCol] = timestampNoti;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nNoticia(id: $idNoticia, \ntit: $titleNoticia, \ndata: $dataNoticia, "
        "\nres: $resumoNoticia, \nlink: $linkNoticia, "
        "\nfoto: $fotoNoticia, \n time: $timestampNoti)";
  }
}