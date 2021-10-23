import 'package:alba_app/helpers/mesadir_helper.dart';
import 'package:alba_app/models/mesadir_model.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PlaceMesaDirWidget extends StatefulWidget {
  PlaceMesaDirWidget();
  @override
  _PlaceMesaDirWidgetState createState() => _PlaceMesaDirWidgetState();
}

class _PlaceMesaDirWidgetState extends State<PlaceMesaDirWidget> {
  MesaDirHelper helperMesa = MesaDirHelper();
  List<MesaDirModel> listMesa = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helperMesa.getAllMesa().then((list) {
      setState(() {
        listMesa = list;
      });
    });
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
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,),
        ),
        drawer: CustomDrawer(),
        body: listaMesaDir(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaMesaDir() {
    return ListView.builder(
      itemCount: listMesa.length,
      itemBuilder: (context, index){
        return Container(
          height: 450.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(18.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.0,
                  offset: Offset(2.0, 5.0),
                )
              ]),
          child: Center(
            child: Card(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/"+listMesa[index].fotoDepMesa,
                    height: 350.0,
                  ),
                  ListTile(
                    title: Center(
                      child: Text(
                        "Dep. "+ listMesa[index].depMesa + " (" + listMesa[index].partDepMesa + ") ",
                        style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        listMesa[index].cargoMesa + " Tel.: (071)" + (listMesa[index].telMesa).substring(0, 9),
                        style: TextStyle( fontWeight: FontWeight.bold, fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}