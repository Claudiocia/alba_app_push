import 'package:alba_app/helpers/controle_helper.dart';
import 'package:alba_app/models/controle_model.dart';
import 'package:package_info/package_info.dart';
import 'package:web_scraper/web_scraper.dart';

class VersionMyApp{
  VersionMyApp();

  ControleHelper controleHelper = ControleHelper();
  ControleModel controle = ControleModel();
  var hoje = DateTime.now();
  PackageInfo packageInfo;
  String versionServidor;


  //Metodo que busca a ultima versão no servidor
  Future<String> loadVersion() async {
    String versaoNew;

    final webScraper = WebScraper('https://smartenem.com.br');
    if(await webScraper.loadWebPage('/noticias/index')){
      List<Map<String, dynamic>> elements = webScraper.getElement( 'div.media-body > a.pr-0.text-decoration-none > h5.mt-0.mb-1', ['']);
      int x = elements.length;
    //  print("O tamanho da lista é: " + x.toString());
     // print("O que vem na lista é: " + elements[0]["title"].toString());
      if(x > 0){
        String nome = elements[0]["title"];
        versaoNew = (nome.substring(8)).trim();
        //print(versaoNew);
      }

    }
    return versaoNew;
  }


  //Metodo que busca as informações do package atual
  Future initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
    return packageInfo;
  }

  verificaVersao(String versAtual) {
    loadVersion().then((value){
      if(value != null){
        versionServidor = value;
        print("o valor na verific versao é: " + value);
        print("Versão servidor é: "+versionServidor + " Versão atual é: " + versAtual);
      }else{
        versionServidor = versAtual;
        print("Não deu tempo");
      }
    });
    if(versionServidor != versAtual){
      print("Versão servidor é: "+versionServidor + " Versão atual é: " + versAtual);
      return true;
    }else{
      return false;
    }
  }
}