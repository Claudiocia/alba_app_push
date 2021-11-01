import 'dart:async';
import 'dart:io';

import 'package:alba_app/pages/maisalba_page.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlaceTVAlbaWidget extends StatefulWidget {
  PlaceTVAlbaWidget();

  @override
  _PlaceTVAlbaWidgetState createState() => _PlaceTVAlbaWidgetState();
}

class _PlaceTVAlbaWidgetState extends State<PlaceTVAlbaWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;
  bool tempo = false;

  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivity.checkConnectivity().then((connectivityResult) {
      _conectivityStatus(connectivityResult);
    });
    _videoPlayerController = VideoPlayerController.network(
        'https://digilab.cds.ebtcvd.net/live-tvalba/stream/playlist.m3u8');
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  _conectivityStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Verifique sua conexão de rede!!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 10),
      ));
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dosis'),
      title: "ALBA APP",
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFF004a92),
            centerTitle: true,
            title: Image.asset(
              "assets/images/marca_mobi_tvalba.png",
              width: 100.0,
            ),
          ),
          drawer: CustomDrawer(),
          backgroundColor: Colors.black,
          body: Center(
            child: FutureBuilder<bool>(
              future: started(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Erro na conexão. Tente mais tarde!',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  else if (snapshot.data == true) {
                    return AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Carregando...',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
              },
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<bool> _onBackPressed() {
    _videoPlayerController.dispose();
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => PlaceMaisAlbaWidget()));
  }
}
