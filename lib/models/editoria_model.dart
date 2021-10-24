
class EditoriaForForm {
  int id;
  String nome;

  EditoriaForForm(this.id, this.nome);

  static getEditoria(String nome){
    int x = 0;
    switch(nome){
      case "Diário Oficial":
        x = 1;
        break;
      case "Notícia":
        x = 2;
        break;
      case "Plenário":
        x = 4;
        break;
      case "Comissões":
        x = 5;
        break;
      case "Sessão Especial":
        x = 6;
        break;
      case "Escola do Legislativo":
        x = 7;
        break;
      case "Exposição":
        x = 8;
        break;
      case "Presidência":
        x = 9;
        break;
      case "Assembleia de Carinho":
        x = 12;
        break;
    }
    return x;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "nome": nome,
    };
    return map;
  }

  static List<String>getEditString(){
    return <String>[
    "Diário Oficial",
    "Notícia",
    "Plenário",
    "Comissões",
    "Sessão Especial",
    "Escola do Legislativo",
    "Exposição",
    "Presidência",
    "Assembleia de Carinho",
    ];
  }
}