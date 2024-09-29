import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Congratulations extends StatefulWidget {
  @override
  _Congratulations createState() => _Congratulations();
}

class _Congratulations extends State<Congratulations> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _horizontalAnimation;
  late double screenWidth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // Total duration for one complete cycle
    )..repeat(reverse: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;

    _horizontalAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: screenWidth + 500, end: screenWidth / 2.04 - 160).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2, // First phase: move from right to center
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(screenWidth / 2.04 - 160),
        weight: 2, // Second phase: stay in the center for 2 seconds
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: screenWidth / 2.04 - 160, end: -500).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2, // Third phase: move from center to left
      ),
    ]).animate(_controller);
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
                  SystemNavigator.pop(); // Close the application
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
            // Background image with opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.2, // Adjust opacity as needed
                child: Image.asset(
                  'assets/welcome_bg.jpg', // Verify the path to the image
                  fit: BoxFit.cover, // Ensure the image covers the entire screen
                ),
              ),
            ),
            // Animated Train GIF
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  left: _horizontalAnimation.value,
                  top: 1, // Position at the top of the screen
                  child: child!,
                );
              },
              child: Image.asset(
                'assets/train_moves.gif', // Replace with actual path to GIF
                height: 350, // Make the GIF larger
              ),
            ),
            // Foreground content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Home Label
                  Text(
                    'Mission Accomplished',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50), // Space between Home label and buttons
                  // Alphabet Button with Label
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/cute-happy-kids.jpg', // Replace with actual path
                            width: 250, // Adjust width as needed
                            height: 200, // Adjust height as needed
                          ),
                      ),
                      SizedBox(height: 10), // Space between button and text
                      Text(
                        '⭐⭐⭐⭐⭐',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold, // Make text bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            // Exit Button
            Positioned(
              bottom: 7,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  SystemNavigator.pop(); // Close the application
                },
                child: Image.asset(
                  'assets/exit_button.png', // Replace with actual path to exit button image
                  height: 100, // Adjust size as needed
                  width: 100, // Adjust size as needed
                ),
              ),
            ),
            // Logout Button
            Positioned(
              bottom: 12,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home'); // Navigate to signup page
                },
                child: Image.asset(
                  'assets/home_button.png', // Replace with actual path to logout button image
                  height: 90, // Adjust size as needed
                  width: 90, // Adjust size as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
