import 'package:alba_app/models/livro_model.dart';
import 'package:alba_app/utils/dialog_inset_defeat.dart';
import 'package:alba_app/utils/livros_api_bd.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlaceAlbaCultWidget extends StatefulWidget {
  PlaceAlbaCultWidget();
  @override
  _PlaceAlbaCultWidgetState createState() => _PlaceAlbaCultWidgetState();
}

class _PlaceAlbaCultWidgetState extends State<PlaceAlbaCultWidget> {
  LivrosApiBd livrosApiBd = LivrosApiBd();
  List<LivroModel> listLivros = [];
  LivroModel livro;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    livrosApiBd.buscarLivros().then((value) {
      setState(() {
        listLivros = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dosis'),
      title: "ALBA APP",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset(
            "assets/images/marca_mobi.png",
            width: 100.0,
          ),
        ),
        drawer: CustomDrawer(),
        body: listaLivros(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaLivros() {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/marca_alba_s.jpg",
              width: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Carregando...",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.separated(
        padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        separatorBuilder: (context, index) => Divider(color: Colors.black54),
        itemCount: listLivros.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              listLivros[index].capaLivro,
              height: 200.0,
              fit: BoxFit.fitHeight,
            ),
            title: Text(
              listLivros[index].titLivro,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            subtitle: Text(
              listLivros[index].edtLivro,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            onTap: () {
              showDialogWithInsets(
                  context: context,
                  edgeInsets: EdgeInsets.symmetric(horizontal: 8),
                  builder: (context) =>AlertDialog(
                    title: Text(
                        "Detalhe do Livro"
                    ),
                    content: Center(
                      heightFactor: 400.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            listLivros[index].capaLivro,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${listLivros[index].titLivro} "+
                                  "\nFormato: ${listLivros[index].formatLivro} "+
                                  "\nAutor: ${listLivros[index].autorLivro } \nResumo: \n${listLivros[index].resumLivro}",
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(
                              true),
                          child: Text('FECHAR'))
                    ],
                  ));
            },
          );
        },
      );
    }
  }
}