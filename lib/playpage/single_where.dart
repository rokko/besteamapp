import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';

class SingleWherePage extends StatefulWidget {
  const SingleWherePage({super.key});
  @override
  State<SingleWherePage> createState() => _SingleWherePageState();
}

class _SingleWherePageState extends State<SingleWherePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _goNext() {
    context.push('/single/training');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1B1B1B),
      drawer: const ProfileDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: -220,
              top: 120,
              child: IgnorePointer(
                child: Icon(Icons.sports_soccer, size: 650, color: Colors.white.withOpacity(0.04)),
              ),
            ),
            Column(
              children: [
                AppHeader(
                  onHomeTap: () => context.go('/home'),
                  onBellTap: () => context.push('/notifications'),
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 14),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                          onPressed: () => context.pop(),
                          splashRadius: 22,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'WHERE DO YOU PLAY?',
                            style: GoogleFonts.oswald(
                              fontSize: 28,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: .8,
                            ),
                          ),
                          Text(
                            'Choose a location for your training',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final circle = 100.0;
                      return Center(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
                          children: [
                            _LocBtn(
                              size: circle,
                              label: 'Home',
                              icon: Icon(Icons.home_filled, color: Colors.white, size: circle * 0.45),
                              onTap: _goNext,
                            ),
                            _LocBtn(
                              size: circle,
                              label: 'Park',
                              icon: Icon(Icons.park, color: Colors.white, size: circle * 0.45),
                              onTap: _goNext,
                            ),
                            _LocBtn(
                              size: circle,
                              label: '5-Pitch',
                              icon: _PitchIco(text: '5', size: circle * 0.5),
                              onTap: _goNext,
                            ),
                            _LocBtn(
                              size: circle,
                              label: '11-Pitch',
                              icon: _PitchIco(text: '11', size: circle * 0.5),
                              onTap: _goNext,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LocBtn extends StatelessWidget {
  final double size;
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  const _LocBtn({required this.size, required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkResponse(
          onTap: onTap,
          radius: size,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Color(0xFF2CC653),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 3))],
            ),
            alignment: Alignment.center,
            child: icon,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}

class _PitchIco extends StatelessWidget {
  final String text;
  final double size;
  const _PitchIco({required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _PitchP(tw: text == '11' ? 0.75 : 0.6),
          ),
          Positioned(
            top: size * 0.05,
            child: Text(
              text,
              style: GoogleFonts.oswald(
                fontSize: size * 0.55,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PitchP extends CustomPainter {
  final double tw;
  _PitchP({required this.tw});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height * 0.7;

    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
    canvas.drawCircle(Offset(cx, cy), size.width * 0.25, paint);
    canvas.drawCircle(Offset(cx, cy), size.width * 0.05, Paint()..color = Colors.white);

    final rectW = size.width * tw;
    final rectH = size.height * 0.55;
    canvas.drawRect(Rect.fromLTRB(cx - rectW / 2, cy - rectH, cx + rectW / 2, cy), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
