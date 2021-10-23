
class FiltroForForm {
  int id;
  String nome;

  FiltroForForm(this.id, this.nome);

  static getFiltros(String nome){
    int x= 0;
    switch(nome){
      case "Por Número":
        x = 1;
        break;
      case "Por Tipo":
        x = 2;
        break;
      case "Por Autor":
        x = 3;
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

  static List<String>getFiltString(){
    return <String>[
      "Por Número",
      "Por Tipo",
      "Por Autor",
    ];
  }
}