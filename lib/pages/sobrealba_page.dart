import 'dart:ui';

import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceSobreAlbaWidget extends StatefulWidget {
  PlaceSobreAlbaWidget();
  @override
  _PlaceSobreAlbaWidgetState createState() => _PlaceSobreAlbaWidgetState();
}

class _PlaceSobreAlbaWidgetState extends State<PlaceSobreAlbaWidget> {

  final textParagrafo_1 = "A Assembleia Legislativa do Estado da Bahia (ALBA) faz parte da "
      "organização política administrativa do estado, conforme preconiza a Constituição "
      "Federal no seu título III, capítulo I. A ALBA é composta por 63 deputados estaduais, "
      "eleitos pelo voto direto para mandatos de quatro anos. Assim, representa a maioria "
      "do povo baiano.";
  final textParagrafo_2 = "Os seus membros têm duas atribuições principais, estabelecidas "
      "nas Constituições Federal e Estadual: legislar e fiscalizar os atos do Poder Executivo "
      "Estadual. O deputado pode propor novas leis ou alterações, além de revogar as já "
      "existentes no âmbito estadual. Pode, inclusive, propor modificações na Constituição "
      "estadual. As propostas são votadas pelo Plenário, depois de passarem por debates e "
      "discussões nas comissões temáticas da Casa.";
  final textParagrafo_3 = "Quando outro Poder estadual propõe uma nova lei ou norma, "
      "esta, obrigatoriamente, deve passar pela Assembleia, que promove o debate, a "
      "análise nas comissões e, só depois de submetida e aprovada no Plenário, vira lei. "
      "A matéria, se aprovada pela Assembleia, segue para o governador do Estado, que tem "
      "quatro deliberações como opção: pode sancionar; pode vetar totalmente; pode vetar "
      "parcialmente; ou devolver ao Legislativo.";
  final textParagrafo_4 = "No caso da sanção, a proposta vira lei tão logo o ato do "
      "governador seja publicado no Diário Oficial. No caso dos vetos, sejam eles "
      "parciais ou total, a proposta volta ao Legislativo, que tem prazo para submeter "
      "o veto ao crivo dos deputados, e que, por sua vez, podem manter ou derrubar o veto. "
      "Quando o veto é derrubado ou a proposição é devolvida ao Legislativo sem veto, nem "
      "sanção, caberá ao Presidente da Casa promulgar e transformar em lei a "
      "proposta dos deputados.";
  final textParagrafo_5 = "A Assembleia também promove uma série de debates sobre "
      "temas que influenciam diretamente a vida do povo baiano. Destes debates, "
      "podem sair diversas propostas. Individualmente, os deputados apresentam "
      "ainda indicações, sugerindo ações a outras autoridades, fiscalizam o cumprimento "
      "do Orçamento, os atos do Executivo, e podem convocar os secretários de Estado "
      "para prestarem informações. Os deputados também propõem homenagens a "
      "personalidades reconhecidamente relevantes para a história da Bahia.";
  final textParagrafo_6 = "Se quiser saber mais, clique aqui para visitar o "
      "nosso portal e conheça a história do Legislativo baiano, desde a sua "
      "criação ainda no tempo do Império.";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dosis'),
      title: "ALBA APP",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,),
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Sobre a ALBA",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/images/alba_fach.jpg",
                        width: 250.0,
                        alignment: Alignment.center,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: Text(textParagrafo_1,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: Text(textParagrafo_2,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: Text(textParagrafo_3,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/alba_plenario.jpg",
                              width: 250.0,
                              alignment: Alignment.center,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: Text(textParagrafo_4,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: Text(textParagrafo_5,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                        child: InkWell(
                          child: Text(textParagrafo_6,
                            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          onTap: () => _launchURL("http://www.al.ba.gov.br/historia-do-legislativo"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  _launchURL(String urlNew) async {
    var url = urlNew;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
