import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

class VoicePlayer extends StatefulWidget {
  const VoicePlayer({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<VoicePlayer> createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<VoicePlayer> {
  bool _isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer
        .seek(newPos); // Jumps to the given position within the audio file
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      if(mounted) {
        setState(() {
        _isPlaying = state == PlayerState.PLAYING;
      });
      }
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      if(mounted) {
        setState(() {
        duration = newDuration;
      });
      }
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      if(mounted) {
        setState(() {
        position = newPosition;
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _isPlaying
            ? IconButton(
                onPressed: () async {
                  if (_isPlaying) {
                    await audioPlayer.pause();
                  }
                },
                icon: Icon(
                  Icons.pause,
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ))
            : IconButton(
                onPressed: () async {
                  if (!_isPlaying) {
                    await audioPlayer.play(widget.url);
                  }
                },
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
            onChanged: (value) async {
              seekToSec(value.toInt());

              await audioPlayer.resume();
            },
          ),
        ),
      ],
    );
  }
}
