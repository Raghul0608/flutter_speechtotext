
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';


// https://www.youtube.com/watch?v=M4gyFL1Nqq4

class SpeechToTextScreen extends StatefulWidget {
  const SpeechToTextScreen({super.key});

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  late SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to text'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: EdgeInsets.only(bottom: 150),
        child: Text(
          _text,
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTapDown: (details) async {
          if(!_isListening) {
            var available = await _speechToText.initialize();
            if(available){
              setState(() {
                _isListening = true;
                _speechToText.listen(
                    onResult: (result){
                      setState(() {
                        _text = result.recognizedWords;
                      });
                    }
                );
              });
            }
          }
        },
        onTapUp: (details){
          setState(() {
            _isListening = false;
          });
          _speechToText.stop();
        },
        child: AvatarGlow(
          endRadius: 75,
          animate: _isListening,
          duration: Duration(microseconds: 2000),
          glowColor: Colors.teal,
          repeat: true,
          repeatPauseDuration: Duration(microseconds: 100),
          showTwoGlows: true,
          child: CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 35,
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
