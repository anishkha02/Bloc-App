import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    // Dispose the player to release resources
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 100),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (isPlaying) {
                  await audioPlayer.pause();
                } else {
                  // Load and play the local audio file
                  try {
                    await audioPlayer.setAsset('assets/audio/audio.mp3');
                    audioPlayer.play();
                  } catch (e) {
                    print('Error loading audio: $e');
                  }
                }
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              child: Text(isPlaying ? 'Pause' : 'Play'),
            ),
          ],
        ),
      ),
    );
  }
}
