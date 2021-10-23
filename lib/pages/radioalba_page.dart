import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class PlaceRadioAlbaWidget extends StatefulWidget {
  PlaceRadioAlbaWidget();
  @override
  _PlaceRadioAlbaWidgetState createState() => _PlaceRadioAlbaWidgetState();
}

class _PlaceRadioAlbaWidgetState extends State<PlaceRadioAlbaWidget> with TickerProviderStateMixin {

  final assetAudioPlayer = AssetsAudioPlayer();
  AnimationController controller;
  bool isPresed = false;
  bool isLoading = false;

  Future _playerRadio() async{
    if(isPresed == false) {
      try {
        await assetAudioPlayer.open(
          Audio.network("https://s14.maxcast.com.br:8290/live"),
        );
        isPresed = true;
      } catch (t) {}
    }

  }

  @override
  void dispose() {
    assetAudioPlayer.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
      setState(() {
      });
    });
    controller.repeat(reverse: true);
    super.initState();
    setState(() {
      _playerRadio();
      isPresed = true;
    });
  }

  _playerStop(){
    if(isPresed == true){
      assetAudioPlayer.pause();
    }
    isPresed = false;
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
          title: Image.asset("assets/images/marca_mobi_radioalba.png",
            width: 100.0,),
        ),
        drawer: CustomDrawer(),
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildMarcaRadio(),
              buidProgressBar(),
              buildButtons(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF004a92),
                  onPrimary: Colors.white,
                  elevation: 30.0,
                  minimumSize: Size(100.0, 45.0),
                ),
                onPressed: () {
                  _playerStop();
                  isPresed = false;
                  Navigator.pop(context);
                },
                child: Text('Sair', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Container buildMarcaRadio(){
    return Container(
      margin: EdgeInsets.all(30),
      child: Container(
        width: MediaQuery.of(this.context).size.width,
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xFF004a92),
          image: DecorationImage(image: AssetImage("assets/images/marca_mobi_radioalba.png")),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15,
              offset: Offset(3, 3),
            ),
          ],
        ),
      ),
    );
  }

  buidProgressBar(){
    if(isPresed){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40, top: 15, right: 40, bottom: 3),
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: controller.value,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF004a92)),
            ),
          ),
        ],
      );
    }else if(!isPresed){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40, top: 15, right: 40, bottom: 3),
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              value: 0.2,
            ),
          ),
        ],
      );
    }
  }

  buildButtons() {
    return Container(
      padding: EdgeInsets.only(left: 50, top: 0, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Icon( isPresed ? Icons.stop_circle_outlined : Icons.play_circle_outline,
              size: 60,
              color: Colors.blueAccent,
            ),
            onPressed: (){
              _playerRadio();
              setState(() {
                if(!isPresed){
                  _playerRadio();
                }else if(isPresed == true){
                  _playerStop();
                }
              });
            },
          ),
        ],
      ),
    );

  }
}