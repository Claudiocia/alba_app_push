import 'dart:async';

import 'package:alba_app/helpers/livro_helper.dart';
import 'package:alba_app/models/livro_model.dart';
import 'package:web_scraper/web_scraper.dart';

class LivrosApiBd {
  LivrosApiBd();
  int max;
  final String htmlAlba = "http://www.al.ba.gov.br";
  List<LivroModel> listLivros = [];
  List<LivroModel> listLivrosBd = [];
  LivroHelper helperLivro = LivroHelper();


  Future<List> loadLivros() async {

    //Método para buscar os livros no site da Alba
    final webScraperLiv = WebScraper(htmlAlba);

    if(await webScraperLiv.loadWebPage("/midia-center/alba-cultural")){

      List<Map<String, dynamic>> numberOfPag =
      webScraperLiv.getElement('ul.pagination > li > a.paginate-button-next.fe-mobile-hide', ['href']);

      var numPag = numberOfPag[0]['attributes'];
      //print("numero de página que vem no scraper ${numberOfPag[0]['attributes']}");
      String pagina = (numPag.toString()).trim();
      //print("A informação trabalhada = a ${pagina}");
      max = int.parse(pagina.substring(40, (pagina.length - 9)));
      //print("valor denominado como max é ${max}");

    }

    //laço para buscar todas as páginas de livros
    for(int i = 0; i <= max; i++){
      if(await webScraperLiv.loadWebPage("/midia-center/alba-cultural?page=$i&size=20")){
        List<Map<String, dynamic>> elements1 =
        webScraperLiv.getElement('div.col-md-5.obra > div.col-md-4 > div > a', ['href']);
        List<Map<String, dynamic>> elements2 =
        webScraperLiv.getElement('div.col-md-5.obra > div.col-md-4 > div > a > img.img-obra', ['src']);
        List<Map<String, dynamic>> elements3 =
        webScraperLiv.getElement('div.title-obra > p', ['']);
        List<Map<String, dynamic>> elements4 =
        webScraperLiv.getElement('div.stitle-obra > span', ['']);

        for(int y = 0; y < elements1.length; y++){
          LivroModel livro = LivroModel();
          var end = elements1[y]['attributes'];
          String link = htmlAlba + (end.toString()).substring(7, (end.toString().length - 1));
          var img = elements2[y]["attributes"];
          String capa = htmlAlba + (img.toString()).substring(6, (img.toString().length - 1));
          var tit = elements3[y]['title'];
          String titulo = (tit.toString()).trim();
          var inf = elements4[y]['title'];
          String info = (inf.toString()).trim();
          String ano = info.substring(info.length - 4);

          livro.linkLivro = link;
          livro.capaLivro = capa;
          livro.titLivro = titulo;
          livro.edtLivro = info;
          livro.dataLivro = ano;
          livro.numPagWeb = max;

          LivroModel livro2 = LivroModel();

          await detalheLivro(livro).then((value){
            livro2 = value;
          });
          await helperLivro.saveLivro(livro2);

          listLivros.add(livro2);
        }
      }
    }



    Comparator<LivroModel> ordemComparator =
        (a, b) => b.dataLivro.compareTo(a.dataLivro);

    listLivros.sort(ordemComparator);


    return listLivros;
  }


  Future<LivroModel> detalheLivro (LivroModel livro) async {
    var livroFut;
    final webScraperLiv = WebScraper(htmlAlba);

    //Complementando dados do livro
    String pagLivro = (livro.linkLivro).substring(23);
    if(await webScraperLiv.loadWebPage(pagLivro)){
      List<Map<String, dynamic>> elementLivro1 =
      webScraperLiv.getElement('div.stitle-obra-detail > div > span', ['']); // autor

      List<Map<String, dynamic>> elementLivro2 =
      webScraperLiv.getElement('div.stitle-obra-detail > div.divider > p', ['']); // resumo

      livro.autorLivro = ((elementLivro1[0]['title']).toString()).trim();
      livro.publicLivro = ((elementLivro1[1]['title']).toString()).trim();
      livro.formatLivro = ((elementLivro1[2]['title']).toString()).trim();
      livro.resumLivro = ((elementLivro2[0]['title']).toString()).trim();
      livro.isbnLivro = ((elementLivro1[3]['title']).toString()).trim();
      livro.fonteLivro = ((elementLivro1[4]['title']).toString()).trim();
    }
    livroFut = livro;
    return livroFut;
  }

  Future<List> buscarLivros() async{
    int exist;
    await helperLivro.getNumber().then((value){
      exist = value;
    });

    if(exist > 0){
      await helperLivro.getAllLivros().then((value){
        listLivrosBd = value;
      });
      return listLivrosBd;
    }else{
      await loadLivros().then((value){
        listLivros = value;
      });
      return listLivros;
    }
  }

  Future atualizarBdLivr() async {
    int numPag, numWeb;
    await helperLivro.getNumberPag().then((value){
      numPag = value;
    });

    await buscarNumPagWeb().then((value){
      numWeb = value;
    });

    if(numPag < numWeb || (numPag == null && numWeb == null)){
      await helperLivro.deleteTabela();
      await helperLivro.getNumber().then((value){
        if(value == 0){
          this.loadLivros().then((value){
            listLivros = value;
          });
          return listLivros;
        }
      });
    }else{
      await helperLivro.getAllLivros().then((value){
        listLivros = value;
      });
      return listLivros;
    }

  }

  Future<int> buscarNumPagWeb() async {
    final webScraperLiv = WebScraper(htmlAlba);

    if(await webScraperLiv.loadWebPage("/midia-center/alba-cultural")){

      List<Map<String, dynamic>> numberOfPag =
      webScraperLiv.getElement('ul.pagination > li > a.paginate-button-next.fe-mobile-hide', ['href']);

      var numPag = numberOfPag[0]['attributes'];
      String pagina = (numPag.toString()).trim();
      max = int.parse(pagina.substring(40, (pagina.length - 9)));

    }

    return max;
  }

}