import 'package:flutter/material.dart';
import 'package:rental_app/views/buyers/nav_screens/landing_first_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeController.forward();
    _navigateToFirstScreen();
  }

  _navigateToFirstScreen() async {
    // Simulate a network call or any other background task
    await Future.delayed(const Duration(seconds: 5), () {});

    // Navigate to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingFirstScreen()),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 107, 174, 230),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 107, 174, 230),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeController,
                child: Image.asset(
                  'assets/image/rentop0.png',
                   // Replace with your image path // Adjust the height as needed
                  width: 230, // Adjust the width as needed
                ),
              ),
              SizedBox(height: 50,),
              CircularProgressIndicator(
                // Customize the color, strokeWidth, etc. as needed
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 6,
                strokeAlign: 3,
              ),
              SizedBox(height: 20,),
              FadeTransition(
                opacity: _fadeController,
                child: Image.asset(
                  'assets/image/text.png', // Replace with your image path // Adjust the height as needed
                  width: 120, // Adjust the width as needed
                ),
              ),
              // RichText(
              //   text: TextSpan(
              //     children: <TextSpan>[
              //       TextSpan(
              //         text: 'RENT',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 50,
              //           color: Colors.blue,
              //         ),
              //       ),
              //       TextSpan(
              //         text: 'UP',
              //         style: TextStyle(
              //           fontSize: 50,
              //           color: Colors.blue,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
