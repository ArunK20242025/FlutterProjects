import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class AlphabetIScreen extends StatefulWidget {
  @override
  _AlphabetIScreenState createState() => _AlphabetIScreenState();
}

class _AlphabetIScreenState extends State<AlphabetIScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _horizontalAnimation;
  late double screenWidth;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: false);

    _audioPlayer = AudioPlayer();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audio/icecream.mp3');
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
      print('Audio playing');
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;

    _horizontalAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: screenWidth + 200, end: screenWidth / 2.05 - 160)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(screenWidth / 2.05 - 160),
        weight: 5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: screenWidth / 2.05 - 160, end: -400)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    print('Dispose method called');
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit VocaBuddy 🐝'),
            content: Text('Are you sure you want to exit 🥺?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
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
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  left: _horizontalAnimation.value,
                  top: 40,
                  child: child!,
                );
              },
              child: Image.asset(
                'assets/children_dance.gif',
                height: 200,
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Alphabet "I" tapped');
                      _playAudio();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Image.asset(
                        'assets/Alphabet_i.jpg',
                        width: 240,
                        height: 240,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      'I for Icecream 🍦',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 14,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Image.asset(
                  'assets/home_button.png',
                  height: 90,
                  width: 90,
                ),
              ),
            ),
            Positioned(
              bottom: 9,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/j');
                },
                child: Image.asset(
                  'assets/next_button.png',
                  height: 110,
                  width: 110,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
