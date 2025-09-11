import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key, required this.onCenterTap});
  final VoidCallback onCenterTap;

  static const _green = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter, end: Alignment.topCenter,
                    colors: [const Color(0xFF0F2A14).withOpacity(0.7), Colors.transparent],
                    stops: const [0.0, 0.9],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.delete_outline, color: Color(0xFFAEC3FF), size: 30),
              GestureDetector(
                onTap: onCenterTap,
                child: Container(
                  width: 64, height: 64,
                  decoration: const BoxDecoration(
                    color: _green, shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 12, offset: Offset(0, 6))],
                  ),
                  alignment: Alignment.center,
                  child: Text('B', style: GoogleFonts.oswald(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ),
              const Icon(Icons.cast, color: Color(0xFFAEC3FF), size: 30),
            ],
          ),
        ],
      ),
    );
  }
}
