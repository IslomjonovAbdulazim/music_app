import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

List<MediaItem> mediaItems = [
  MediaItem(
    id: "assets://assets/Rihanna - California King Bed.mp3",
    title: "California King Bed",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - Cheers (Drink To That).mp3",
    title: "Cheers (Drink To That)",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - Complicated with Lyrics.mp3",
    title: "Complicated with Lyrics",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - Fading (Lyrics).mp3",
    title: "Fading (Lyrics)",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - Love The Way You Lie ft. Eminem(Part 2).flv.mp3",
    title: "Love The Way You Lie ft. Eminem (Part 2)",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - Man Down.mp3",
    title: "Man Down",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - Only Girl (In The World).mp3",
    title: "Only Girl (In The World)",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - Raining men.mp3",
    title: "Raining men",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - S_u0026M.mp3",
    title: "S_u0026M",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Rihanna - What's My Name? ft. Drake.mp3",
    title: "What's My Name? ft. Drake",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
  ),
  MediaItem(
    id: "assets://assets/Skin - Rihanna (Lyrics).mp3",
    title: "Skin (Lyrics)",
    artUri: Uri.parse("https://upload.wikimedia.org/wikipedia/commons/b/be/Cristiano_Ronaldo%2C_2023.jpg"),
    artist: "Rihanna",
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
