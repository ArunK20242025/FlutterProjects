import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _horizontalAnimation;
  late Animation<double> _verticalAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    )..repeat(reverse: false);

    _verticalAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -10, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _horizontalAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: -700, end: MediaQuery.of(context).size.width / 2 - 210)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(MediaQuery.of(context).size.width / 2 - 210),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: MediaQuery.of(context).size.width / 2 - 210, end: MediaQuery.of(context).size.width + 450)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Adjust opacity as needed
              child: Image.asset(
                'assets/welcome_bg.jpg', // Verify the path to the image
                fit: BoxFit.cover, // Ensure the image covers the entire screen
              ),
            ),
          ),
          // Foreground content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_horizontalAnimation.value, _verticalAnimation.value),
                      child: child,
                    );
                  },
                  child: Image.asset('assets/welcome_animation.gif'),
                ),
                SizedBox(height: 60),
                Text(
                  'Welcome to VocaBuddy!',
                  textAlign: TextAlign.center, // Ensure the text is centered horizontally
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico', // Use a funky font like Pacifico
                    color: Color.fromARGB(255, 8, 128, 168), // Use a funky color
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    '🖐️',
                    style: TextStyle(fontSize: 42), // Adjust font size as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
