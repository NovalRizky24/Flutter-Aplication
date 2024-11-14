import 'package:flutter/material.dart';
import 'dart:async';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showLogo = false;
  bool _showText = false;
  bool _showAdditionalText = false;
  bool _showLoadingBar = false; // Flag untuk menampilkan loading bar

  @override
  void initState() {
    super.initState();

    // Show logo after a short delay
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _showLogo = true;
      });
    });

    // Show text after the logo
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showText = true;
      });
    });

    // Show additional text after another delay
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showAdditionalText = true;
      });
    });

    // Show loading bar after the text
    Timer(const Duration(seconds: 4), () {
      setState(() {
        _showLoadingBar = true;
      });
    });

    // Navigate to login page after the splash screen
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightGreenAccent,
              Colors.tealAccent,
              Colors.teal.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Logo using AnimatedOpacity, now inside ClipOval for circular shape
              AnimatedOpacity(
                opacity: _showLogo ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: ClipOval(
                  child: Image.asset(
                    'images/poto.png',  // Ganti dengan path gambar Anda
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Animated Text using AnimatedOpacity
              AnimatedOpacity(
                opacity: _showText ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.teal.shade700, Colors.teal],
                      ).createShader(bounds),
                      child: const Text(
                        'NOVAL RIZKY',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 3,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '152022171',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.teal.shade700,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),

              // Additional animated text using AnimatedOpacity
              AnimatedOpacity(
                opacity: _showAdditionalText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Welcome to My App',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),

              // Loading Bar using AnimatedOpacity
              AnimatedOpacity(
                opacity: _showLoadingBar ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(
                    color: Colors.teal.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
