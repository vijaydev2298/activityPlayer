import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

class VoiceHome extends StatefulWidget {
  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  @override
  void initState(){
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result)
    );
    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true)
    );
    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech)
    );
    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false)
    );
    _speechRecognition.activate().then(
      (result) => setState(() => _isAvailable = result)
    );
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              width: 270.0,
              child:Text(
                'Press the mic button and start talking...',
                style: TextStyle(
                  fontSize: 15)
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: Colors.cyan[200],
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Text(resultText),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                FloatingActionButton(
                  mini: true,
                  heroTag: "btn1",
                  child: Icon(Icons.cancel),
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    if (!_isListening)
                      _speechRecognition
                        .stop()
                        .then((result) => setState(() {
                          _isListening = result;
                          resultText = "";
                        }));
                  }
                  ),
                FloatingActionButton(
                  heroTag: "btn2",
                  child: Icon(Icons.mic),
                  onPressed: () {
                    if (_isAvailable && !_isListening)
                      _speechRecognition
                        .listen(locale: "en_US")
                        .then((result) => print('$result'));
                  }
                  ),
                FloatingActionButton(
                  heroTag: "btn3",
                  mini: true,
                  child: Icon(Icons.stop),
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition
                        .stop()
                        .then((result) => setState(() => _isListening = result));
                  }
                  ),
              ]
            )
          ],),
      )
    );
  }
}