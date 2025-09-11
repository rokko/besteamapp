import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.onHomeTap,
    this.onBellTap,
    this.onMenuTap,
  });

  final VoidCallback? onHomeTap;
  final VoidCallback? onBellTap;
  final VoidCallback? onMenuTap;

  static const _headerBg = Color(0xFF222222);
  static const _green    = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: _BottomCurveClipper(),
              child: Container(color: _headerBg),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.home_outlined, color: Colors.white, size: 24),
                  onPressed: onHomeTap,
                  splashRadius: 22,
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.notifications, color: _green, size: 24),
                  onPressed: onBellTap,
                  splashRadius: 22,
                ),
                const Spacer(),
                const Icon(Icons.sports_soccer, color: _green, size: 26),
                const SizedBox(width: 18),
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                  onPressed: onMenuTap,
                  splashRadius: 22,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height, w = size.width;
    return Path()
      ..lineTo(0, h - 40)
      ..quadraticBezierTo(w * .5, h, w, h - 40)
      ..lineTo(w, 0)
      ..close();
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
