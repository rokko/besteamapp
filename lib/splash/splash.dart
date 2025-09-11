import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Simula init o call async; poi vai all'onboarding/home
    Timer(const Duration(seconds: 2), () {
      if (mounted) context.go('/onboarding'); // o '/home'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // niente appBar, così lo sfondo copre tutto
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SFONDO A PIENO SCHERMO
          Image.asset(
            'assets/images/sfondo_splash.png',
            fit: BoxFit.cover, // copre tutto, niente immagine “piccola”
          ),
          // overlay (logo/animazione/bottone)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Se vuoi un logo sopra allo sfondo:
                Image.asset('assets/images/logo.png', width: 120),
                const SizedBox(height: 16),
                const CircularProgressIndicator(), // opzionale
              ],
            ),
          ),
        ],
      ),
    );
  }
}
