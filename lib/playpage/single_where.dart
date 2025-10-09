import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

// Header & Drawer riusabili (gli stessi usati in Home/Play)
import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';

class SingleWherePage extends StatefulWidget {
  const SingleWherePage({super.key});
  @override
  State<SingleWherePage> createState() => _SingleWherePageState();
}

class _SingleWherePageState extends State<SingleWherePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const kBg    = Color(0xFF1B1B1B);
  static const kGreen = Color(0xFF2CC653);

  void _goNext() {
    // GoRouter
    context.push('/single/training');
    // Navigator (se NON usi GoRouter):
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SingleTrainingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBg,
      drawer: const ProfileDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            // watermark pallone tenue
            Positioned.fill(
              child: IgnorePointer(
                child: Align(
                  alignment: const Alignment(-0.75, -0.05),
                  child: Icon(Icons.sports_soccer, size: 520, color: Colors.white.withOpacity(0.06)),
                ),
              ),
            ),

            Column(
              children: [
                // header condiviso
                AppHeader(
                  onHomeTap: () => context.go('/home'),
                  onBellTap: () => context.push('/notifications'),
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),

                // back + titolo + sottotitolo
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Colors.white),
                        onPressed: () => context.pop(),
                        splashRadius: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          'WHERE DO YOU PLAY?',
                          style: GoogleFonts.oswald(
                            fontSize: 32,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: .8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 2),
                        child: Text(
                          'Choose a location for your training',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // griglia 2x2 (Home, Park, 5-Pitch, 11-Pitch)
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cell = (constraints.maxWidth - 24 * 2 - 24) / 2; // larghezza cella ~like mock
                      final circle = 96.0;

                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        crossAxisCount: 2,
                        mainAxisSpacing: 26,
                        crossAxisSpacing: 24,
                        children: [
                          _RoundIcon(
                            size: circle,
                            label: 'Home',
                            icon: Icons.home_filled,
                            onTap: _goNext,
                          ),
                          _RoundIcon(
                            size: circle,
                            label: 'Park',
                            icon: Icons.park_outlined, // più compatibile
                            onTap: _goNext,
                          ),
                          _RoundNumber(
                            size: circle,
                            number: '5',
                            label: '5-Pitch',
                            onTap: _goNext,
                          ),
                          _RoundNumber(
                            size: circle,
                            number: '11',
                            label: '11-Pitch',
                            onTap: _goNext,
                          ),
                        ],
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

/* ---------------------- UI widgets ---------------------- */

class _RoundIcon extends StatelessWidget {
  final double size;
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIcon({
    required this.size,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  static const kGreen = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkResponse(
          onTap: onTap,
          radius: size,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: kGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.85), width: 2),
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 3))],
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: size * 0.46),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}

class _RoundNumber extends StatelessWidget {
  final double size;
  final String number;
  final String label;
  final VoidCallback onTap;
  const _RoundNumber({
    required this.size,
    required this.number,
    required this.label,
    required this.onTap,
  });

  static const kGreen = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkResponse(
          onTap: onTap,
          radius: size,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: kGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.85), width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 3))],
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: GoogleFonts.oswald(
                    fontSize: size * 0.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: Container(
                  width: size * 0.33,
                  height: size * 0.33,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(Icons.sports_soccer, size: size * 0.21, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
