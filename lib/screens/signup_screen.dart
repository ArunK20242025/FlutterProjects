import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _horizontalAnimation;
  late AudioPlayer _audioPlayer;
  String _selectedGender = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);

    _audioPlayer = AudioPlayer();

    // Load and play audio when the screen is loaded
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audio/next_step.mp3');
      _playAudio();
    } catch (e) {
      print('Error loading audio: $e');
      // Handle error here
    }
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.play();
      print('Audio playing');
    } catch (e) {
      print('Error playing audio: $e');
      // Handle error here
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.stop(); // Stop audio when the screen is disposed
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _horizontalAnimation = Tween<double>(begin: -100, end: screenWidth + 100)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/welcome_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/students_learn.png',
                      height: 220,
                    ),
                    SizedBox(height: 35),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Super Hero Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Superhero Identity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Superhero Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Superhero Age',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/secondScreen');
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                left: _horizontalAnimation.value,
                bottom: 20,
                child: child!,
              );
            },
            child: Image.asset(
              'assets/welcome_animation.gif',
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
