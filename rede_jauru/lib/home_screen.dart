
import 'package:audio_service/audio_service.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:wakelock/wakelock.dart';


class MyHomePage extends StatefulWidget {
  @override

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const streamUrlSR =
      "http://centova6.ciclanohost.com.br:9038/stream.mp3";
  static const streamUrlS = "http://centova6.ciclanohost.com.br:9043/stream";

  /* static const streamUrlSR =
      "https://r6.ciclano.io:15008/stream";
  static const streamUrlS = "https://r6.ciclano.io:15006/stream";*/
  String playUrl = streamUrlSR;
  String playRadio = '';
  String _tocando = '';
  bool playing = false;
  bool isPlaying;
  var _appbarColor = Colors.blue;

  var _colorsBtn = Colors.blue;

  @override
  void initState() {
    super.initState();
    AudioService . connect ();
    audioStart();
    playingStatus();
    initPlatformState();

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 2,
        stopOnTerminate: false,
        enableHeadless: false,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE
    ), (String taskId) async {
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      setState(() {

      });
    });
  }
  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REDE JAURU',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: _appbarColor,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: LayoutBuilder(builder: (_, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: constraints.maxWidth * .9,
                        height: constraints.maxHeight / 4,
                        //color: Colors.black,
                        child: GestureDetector(
                          onTap: () {
                            if (playRadio != 'SR') {
                              FlutterRadio.play(url: streamUrlSR);
                              playingStatus();
                              setState(() {
                                _appbarColor = Colors.blue;
                                _colorsBtn = Colors.blue;
                                playRadio = 'SR';
                                playUrl = streamUrlSR;
                                playing = true;
                                _tocando = 'SÃO ROQUE';
                              });
                            }
                          },
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset('assets/images/sao-roque.png',
                                  width: 70.0, height: 60.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * .9,
                        height: constraints.maxHeight / 4,
                        //color: Colors.blue,
                        child: GestureDetector(
                          onTap: () {
                            if (playRadio != 'LS') {
                              FlutterRadio.play(url: streamUrlS);
                              playingStatus();
                              setState(() {
                                _appbarColor = Colors.red;
                                _colorsBtn = Colors.red;

                                playRadio = 'LS';
                                playUrl = streamUrlS;
                                playing = true;
                                _tocando = " LA SORELLA";
                              });
                            }
                          },
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset('assets/images/la-sorella.png',
                                  width: 60.0, height: 50.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: constraints.maxWidth * .9,
                        height: constraints.maxHeight / 4,
                        //color: Colors.deepPurple,
                        child: Text(
                          'Tocando: $_tocando'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * .9,
                        height: constraints.maxHeight / 4,
                        //color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                                child: playing
                                    ? new Icon(Icons.pause_circle_filled,
                                        size: 90, color: _colorsBtn)
                                    : new Icon(Icons.play_circle_filled,
                                        size: 90, color: _colorsBtn),
                                onPressed: () {


                                  if (playing == true) {
                                    setState(() {
                                      playing = false;
                                    });

                                    FlutterRadio.playOrPause(url: playUrl);
                                    playingStatus();

                                  } else {
                                    setState(() {
                                      playing = true;

                                      FlutterRadio.playOrPause(url: playUrl);
                                      if (playUrl == streamUrlS) {
                                        _tocando = "La Sorella";
                                      } else {
                                        _tocando = " São Roque";
                                      }
                                    });
                                  }
                                }),
                            FlatButton(
                              child:
                                  Icon(Icons.stop, size: 60, color: _colorsBtn),
                              onPressed: () {
                                if (playing == true) {
                                  FlutterRadio.stop();
                                  setState(() {
                                    playing = false;
                                    _tocando = '';
                                  });
                                }
                                //playingStatus();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future playingStatus() async {
    bool isP = await FlutterRadio.isPlaying();
    setState(() {
      isPlaying = isP;
    });
  }
}
