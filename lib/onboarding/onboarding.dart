import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  // ---> Usa i NOMI ESATTI dei file
  final _images = const [
    'assets/images/onb1.png',
    'assets/images/onb2.png',
    'assets/images/onb3.png',
  ];

  void _nextOrFinish() {
    if (_index == _images.length - 1) {
      context.go('/registrazione');
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // evita flash/bordi
      body: Stack(
        children: [
          // FULLSCREEN CAROUSEL
          PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemCount: _images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => GestureDetector(
              onTap: _nextOrFinish, // tap per avanzare
              child: SizedBox.expand(
                child: Image.asset(
                  _images[i],
                  fit: BoxFit.cover,      // COPRE tutto lo schermo
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),

          // DOTS
          Positioned(
            left: 0,
            right: 0,
            bottom: 24 + MediaQuery.of(context).padding.bottom,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: _images.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white.withOpacity(0.35),
                ),
                onDotClicked: (i) => _controller.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOut,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
