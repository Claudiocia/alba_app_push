import 'package:alba_app/helpers/noticia_helper.dart';
import 'package:alba_app/models/noticia_model.dart';
import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

class NewsPesqApi {
  NewsPesqApi();
  List<NoticiaModel> listNews = [];

  String palav = "";
  String edtId = "";
  String dtIni = "";
  String dtFim = "";
  DateTime dtHoje = DateTime.now();

  String link;
  int max;
  String pagHtml;
  String pg;

  Future<List> loadPesqNews({String palavra, DateTime dataInicio, DateTime dataFim, int editId}) async {
    if (palavra != '') {
      palav = palavra;
    }
    if (dataInicio != null) {
      final df = new DateFormat('dd-MM-yyyy hh:mm a');
      var dataIn = df.format(dataInicio);
      dtIni = (dataIn.substring(0, 10)).replaceAll("-", "%2F");
    }
    if (dataFim != null) {
      final df = new DateFormat('dd-MM-yyyy hh:mm a');
      var dataIn = df.format(dataInicio);
      dtFim = (dataIn.substring(0, 10)).replaceAll("-", "%2F");
    }

    if (editId != 0) {
      edtId = editId.toString();
    }

    //Metodo para buscar as noticias no site da Alba
    final webScraper = WebScraper('http://www.al.ba.gov.br');
    if (dataInicio != null || dataFim != null) {
      if (dataFim == null) {
        dataFim = DateTime.now();
      } else {
        if (dataInicio == null) {
          dataInicio = dataFim.add(new Duration(days: -90));
        }
        print("Data Inicio: ${dataInicio}");
        print("data Fim: ${dataFim}");
        int result = dataInicio.compareTo(dataFim);
        print("resultado da comparação é: ${result}");
        if (result < 0) {

        }
      }
    }

    pagHtml =
    "/midia-center/noticias?palavra=${palav}&dataInicio=${dtIni}&dataFim=${dtFim}&editoriaId=${edtId}";

    if (await webScraper.loadWebPage(pagHtml + "&page=0&size=20")) {
      List<Map<String, dynamic>> numberOfPag =
      webScraper.getElement(
          'ul.pagination > li > a.paginate-button-next.fe-mobile-hide',
          ['href']);

      if (numberOfPag.length > 0) {
        var numPag = numberOfPag[0]['attributes'];
        String pagina = (numPag.toString()).trim();
        int c = pagina.length;
        for (int i = 0; i < c - 6; i++) {
          if (pagina.substring(i, i + 6) == "&page=") {
            pg = pagina.substring(i + 6, (pagina.length - 9));
          }
        }
        max = int.parse(pg);
        if (max > 1) {
          max = 1;
        }
      } else {
        max = 0;
      }
    }
    //inicia a busca de noticias
    for (int pag = 0; pag <= max; pag++) {
      String pagHtml2 = pagHtml + "&page=$pag&size=20";
      if (await webScraper.loadWebPage(pagHtml2)) {
        //lista com endereço das imagens
        List<Map<String, dynamic>> elements2 =
        webScraper.getElement('img.media-object', ['src']);
        //lista com as manchetes e link da matéria
        List<Map<String, dynamic>> elements =
        webScraper.getElement('h5.media-heading > a.title-new', ['href']);
        List<Map<String, dynamic>> elements3 =
        webScraper.getElement('h5.media-heading > b.title-new', ['']);
        List<Map<String, dynamic>> elements4 =
        webScraper.getElement('div.media-body > p.sub-title-new', ['']);


        for (int i = 0; i < elements.length; i++) {
          NoticiaModel noti = NoticiaModel();
          var nome = elements[i]["title"];
          String tit = (nome as String).trim();
          var email = elements[i]['attributes'];
          String link = "http://www.al.ba.gov.br" +
              (email.toString()).substring(7, (email.toString()).length - 1);
          var image = elements2[i]['attributes'];
          String img = "http://www.al.ba.gov.br" +
              (image.toString()).substring(6, (image.toString()).length - 1);
          var data = elements3[i]['title'];
          String datHora =
          (data.toString()).substring(0, (data.toString()).length - 3);
          String res = (elements4[i]['title']).toString();

          noti.titleNoticia = tit;
          noti.dataNoticia = datHora;
          noti.resumoNoticia = res;
          noti.linkNoticia = link;
          noti.fotoNoticia = img;

          listNews.add(noti);
        }
      }
    }
    return listNews;
  }
}