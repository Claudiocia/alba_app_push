

class ProposicaoModel {
  String linkProposi;
  String ementProposi;
  String numerProposi;
  String autorProposi;
  String localProposi; //lugar onde a proposição se encontra quand em tramitação
  String dataProposi; //data de entrada da proposição na alba
  String aprovProposi; //data da aprovação ou arquivamento da proposição
  String resultProposi; //Resultado da proposição se foi aprovada, rejeitada ou arquivada

  ProposicaoModel();

  ProposicaoModel.fromMap(Map map){
    linkProposi = map["linkProposi"];
    ementProposi = map["ementProposi"];
    numerProposi = map["numerProposi"];
    autorProposi = map["autorProposi"];
    localProposi = map["localProposi"];
    dataProposi = map["dataProposi"];
    aprovProposi = map["aprovProposi"];
    resultProposi = map["resultProposi"];
  }

  Map toMap(){
    Map<String, dynamic> map ={
      "linkProposi": linkProposi,
      "ementProposi": ementProposi,
      "numerProposi": numerProposi,
      "autorProposi": autorProposi,
      "localProposi": localProposi,
      "dataProposi": dataProposi,
      "aprovProposi": aprovProposi,
      "resultProposi": resultProposi,
    };
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "\nLink: $linkProposi \nEmenta: $ementProposi \nNum.: $numerProposi "+
        "\nAutor: $autorProposi \nLocal Atual: $localProposi "
            "\nData de apres.: $dataProposi \nData da Ult. Tram: $aprovProposi "
            "\nSitFinal: $resultProposi";
  }

}