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
  double progress = 0;

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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Now Playing"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    widget.item.artUri.toString(),
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.item.artist ?? "No Artist",
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Icon(CupertinoIcons.heart),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 1.5,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 8,
                    ),
                  ),
                  child: Slider(
                    padding: EdgeInsets.zero,
                    value: progress,
                    activeColor: Color(0xff434343),
                    thumbColor: Color(0xff5C5C5C),
                    onChanged: (value) {
                      progress = value;
                      setState(() {});
                    },
                  ),
                ),
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
      ),
    );
  }
}
