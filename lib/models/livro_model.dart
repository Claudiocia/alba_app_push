


class LivroModel {
  int idLivro;
  String titLivro;
  String linkLivro;
  String capaLivro;
  String edtLivro;
  String autorLivro;
  String publicLivro;
  String formatLivro;
  String resumLivro;
  String isbnLivro;
  String fonteLivro;
  String dataLivro;
  int numPagWeb;

  LivroModel();

  LivroModel.fromMap(Map map){
    idLivro = map["idLivro"];
    titLivro = map["titLivro"];
    linkLivro = map["linkLivro"];
    capaLivro = map["capaLivro"];
    edtLivro = map["edtLivro"];
    autorLivro = map["autorLivro"];
    publicLivro = map["publicLivro"];
    formatLivro = map["formatLivro"];
    resumLivro = map["resumLivro"];
    isbnLivro = map["isbnLivro"];
    fonteLivro = map["fonteLivro"];
    dataLivro = map["dataLivro"];
    numPagWeb = map["numPagWeb"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "titLivro":  titLivro,
      "linkLivro": linkLivro,
      "capaLivro": capaLivro,
      "edtLivro": edtLivro,
      "autorLivro": autorLivro,
      "publicLivro": publicLivro,
      "formatLivro": formatLivro,
      "resumLivro": resumLivro,
      "isbnLivro": isbnLivro,
      "fonteLivro": fonteLivro,
      "dataLivro": dataLivro
    };
    if(idLivro != null){
      map["idLivro"] = idLivro;
      map["numPagWeb"] = numPagWeb;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nLivro(id: $idLivro, \nTit: $titLivro, \nLink: $linkLivro, \nImg: $capaLivro, "
        "\nEdicao: $edtLivro, \nAutor: $autorLivro, \nDadosPublic: $publicLivro, \nFormato: $formatLivro, "
        "\nResum: $resumLivro, \nISBN: $isbnLivro, \nFonte: $fonteLivro, \nData: $dataLivro)";
  }

}