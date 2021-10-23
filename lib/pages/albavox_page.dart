import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class PlaceAlbavoxWidget extends StatefulWidget {
  PlaceAlbavoxWidget();
  @override
  _PlaceAlbavoxWidgetState createState() => _PlaceAlbavoxWidgetState();
}

class _PlaceAlbavoxWidgetState extends State<PlaceAlbavoxWidget> {
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
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Cheguei na página AlbaVox"),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Retornar'),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}