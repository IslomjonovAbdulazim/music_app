import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/main.dart';

class MusicPage extends StatefulWidget {
  final MediaItem item;

  const MusicPage({super.key, required this.item});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    audioHandler.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              StreamBuilder(
                stream: audioHandler.playbackState,
                builder: (context, snapshot) {
                  final playing = snapshot.data?.playing == true;
                  return CupertinoButton(
                    onPressed: () {},
                    child: Icon(
                      playing ? CupertinoIcons.pause : CupertinoIcons.play,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
