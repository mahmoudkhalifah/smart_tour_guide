// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

class VoicePlayer extends StatefulWidget {
  const VoicePlayer({Key? key}) : super(key: key);

  @override
  State<VoicePlayer> createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<VoicePlayer> {
  bool _isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  static const url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer.seek(newPos); // Jumps to the given position within the audio file
  }
  void changeVolume(double value) {
    audioPlayer.setVolume(value);
  }
  @override
  void initState(){
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state){
      setState((){
        _isPlaying=state==PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration){
      setState((){
        duration=newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition){
      setState((){
        position=newPosition;

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _isPlaying
            ? IconButton(
            onPressed: ()async{
              if(_isPlaying){
                await audioPlayer.pause();

              } },

            icon: Icon(
              Icons.pause,
              size: 35,
              color: Theme.of(context).colorScheme.primary,
            ))
            : IconButton(
          onPressed: ()async{
            if(!_isPlaying){
              audioPlayer.setVolume(9.6);
              await audioPlayer.play(url);

            } },

          icon: Icon(
            Icons.play_arrow,
            size: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value)async{
            seekToSec(value.toInt());

            await audioPlayer.resume();
            },
          ),
        ),
      ],
    );
  }
}