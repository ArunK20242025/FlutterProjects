import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _verticalAnimation;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _verticalAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _audioPlayer = AudioPlayer();
    _loadAudio(); // Load and play audio when the screen is loaded
  }

  Future<void> _loadAudio() async {
    try {
      // Load 'welcome_voice.mp3' from assets folder
      await _audioPlayer.setAsset('assets/audio/welcome_voice.mp3');
      _playAudio(); // Play audio
    } catch (e) {
      print('Error loading audio: $e');
      // Handle error here
    }
  }

  Future<void> _playAudio() async {
    try {
      // Play loaded audio
      await _audioPlayer.play();
      print('Audio playing'); // Debugging message
    } catch (e) {
      print('Error playing audio: $e');
      // Handle error here
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose(); // Dispose AudioPlayer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Dimming Overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Adjust opacity as needed
              child: Image.asset(
                'assets/welcome_bg.jpg', // Verify the path to the image
                fit: BoxFit.cover, // Ensure the image covers the entire screen
              ),
            ),
          ),
          // Centered Bee Image with Animation
          Positioned(
            left: screenWidth / 3.3 - 90, // Adjust position as needed
            top: screenHeight / 3, // Adjust position as needed
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _verticalAnimation.value),
                  child: child,
                );
              },
              child: Image.asset(
                'assets/welcome_animation.gif',
                height: 360, // Adjust height for larger bee
              ),
            ),
          ),
          // Message Bubble above Bee Image
          Positioned(
            left: screenWidth / 2.5 - 75, // Adjust position as needed
            top: screenHeight / 3 - 100, // Adjust position as needed
            child: DialogueBubble(
              text: 'Hi kidz, I\'m VocaBuddy!\nWelcome you all!',
            ),
          ),
          // Proceed Button Centered at the Bottom
          Positioned(
            left: screenWidth / 1.8 - 100, // Adjust position as needed
            bottom: 80, // Adjust position as needed
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 22),
              ),
              child: const Text(
                'Let\'s Go !!',
                style: TextStyle(fontWeight: FontWeight.bold), // Make text bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogueBubble extends StatelessWidget {
  final String text;

  const DialogueBubble({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
