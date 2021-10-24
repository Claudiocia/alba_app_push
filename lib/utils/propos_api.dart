import 'package:alba_app/models/proposicao_model.dart';
import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

class PropositionApi {
  PropositionApi();

  final String htmlAlba = "https://www.al.ba.gov.br";
  List<ProposicaoModel> proposiList = [];
  String porNumero = ""; //filtro 1
  String porTipo = ""; //filtro 2
  String porDep = ""; //filtro 3
  String porExec = ""; //filtro 3
  String dataIni = "";
  String dataFim = "";
  String link;
  int max;
  int banco;
  var pagHtml;
  String pg;

  // ignore: missing_return
  Future<List> loadProposic({int filtro, String valor, int bancoPesq}) async {
    final webScraperLiv = WebScraper(htmlAlba);
    if(bancoPesq != null){
      banco = bancoPesq;
    }else{
      banco = 2;
    }

    switch(filtro){
      case 1:
        valor = valor.replaceAll("/", "%2F");
        porNumero = valor;
        break;
      case 2:
        porTipo = valor;
        break;
      case 3:
        if(valor == "4105" && banco == 2) {
          porExec = valor;
        }else if(valor == "4105" && banco == 1) {
          porExec = "66";
        }else {
          porDep = valor;
        }
        break;
      default:
        DateTime dataHoje = DateTime.now();
        DateTime data90 = dataHoje.add(new Duration(days: -180));
        DateTime data19Jan = DateTime(2021, 1, 19, 0, 0, 0, 0);
        DateTime dt90;
        int result = data90.compareTo(data19Jan);
        if(result < 0){
          dt90 = data19Jan;
        }else{
          dt90 = data90;
        }
        final df = new DateFormat('dd-MM-yyyy hh:mm a');
        var hj = df.format(dataHoje);
        var d90 = df.format(dt90);
        String hoje = (hj.substring(0, 10)).replaceAll("-", "%2F");
        String dia90 = (d90.substring(0, 10)).replaceAll("-", "%2F");
        dataIni = dia90;
        dataFim = hoje;
        break;
    }
    if(banco == 2){
      pagHtml = "/atividade-legislativa-nova/proposicoes?numero=$porNumero&palavra=&tipo=$porTipo&deputado=$porDep&exDeputado=&outros=$porExec&dataInicio=$dataIni&dataFim=$dataFim";
    }else{
      pagHtml = "/atividade-legislativa/proposicoes?numero=$porNumero&palavra=&tipo=$porTipo&deputado=$porDep&exDeputado=&outros=$porExec&dataInicio=$dataIni&dataFim=$dataFim";
    }

    //determina o numero de páginas resultante da busca
    if(await webScraperLiv.loadWebPage(pagHtml+"&page=0&size=20")){
      List<Map<String, dynamic>> numberOfPag =
      webScraperLiv.getElement('ul.pagination > li > a.paginate-button-next.fe-mobile-hide', ['href']);

      print("O que volta da busca numero de pagina é: $numberOfPag");

      if(numberOfPag.length > 0) {
        var numPag = numberOfPag[0]['attributes'];
        print(
            "numero de página que vem no scraper ${numberOfPag[0]['attributes']}");
        String pagina = (numPag.toString()).trim();
        print("A informação trabalhada ${pagina}");
        int c = pagina.length;
        for (int i = 0; i < c - 6; i++) {
          if (pagina.substring(i, i + 6) == "&page=") {
            pg = pagina.substring(i + 6, (pagina.length - 9));
          }
        }
        max = int.parse(pg);
        if (max > 3) {
          max = 3;
        }
      }else{
        max = 0;
      }
    }

    //inicia a busca das proposições para a lista

    for(int pag = 0; pag <= max; pag++){

    //int pag =0;
      print("o numero da pagina pesquisado é: ${pag}");
      String pagHtml2 = pagHtml+"&page=$pag&size=20";
      if(await webScraperLiv.loadWebPage(pagHtml2)){
        print("o link de pesquisa${pagHtml2}");
        List<Map<String, dynamic>> elements1 =
        webScraperLiv.getElement("button.btn.fe-btn-alba.fe-btn-min-r.fe-center-x > span", [""]); //num
        List<Map<String, dynamic>> elements2 =
        webScraperLiv.getElement("tr.table-itens > td > span", [""]); // ementa
        List<String> elements3 =
        webScraperLiv.getElementAttribute("tr.table-itens > td.mapa > a", "href");

        if(elements1.length > 0){

          for(int i =0; i < elements2.length; i++) {
            ProposicaoModel proposi = ProposicaoModel();

            var descr = elements2[i]["title"];
            String ement = (descr.toString()).trim();

            var numProp = elements1[i]["title"];
            String numerProposi = (numProp.toString()).trim();
            print("O numero da proposição é: ${numerProposi}");
            //String end = numerProposi.replaceAll("/", "-");
            String end = elements3[i];
            //link = "$htmlAlba/atividade-legislativa/proposicao/$end";
            link = htmlAlba+end;
            print("O links é: ${link}");
            proposi.linkProposi = link;
            proposi.ementProposi = ement;
            proposi.numerProposi = numerProposi;

            proposiList.add(proposi);
          }
        }
      }
    }
    return proposiList;
  }
}