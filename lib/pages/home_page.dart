import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

List<MediaItem> mediaItems = [
  MediaItem(
    id: "assets://assets/Rihanna - California King Bed.mp3",
    title: "California King Bed",

  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
