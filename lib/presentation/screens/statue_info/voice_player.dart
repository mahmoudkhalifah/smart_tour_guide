// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class VoicePlayer extends StatefulWidget {
  const VoicePlayer({Key? key}) : super(key: key);

  @override
  State<VoicePlayer> createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<VoicePlayer> {
  bool _isPlaying = false;
  int time = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _isPlaying
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
                icon: Icon(
                  Icons.pause,
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ))
            : IconButton(
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
                icon: Icon(
                  Icons.play_arrow,
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        Expanded(
          child: Slider(
            value: time.toDouble(),
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                time = value.toInt();
                print(time);
              });
            },
          ),
        ),
      ],
    );
  }
}
