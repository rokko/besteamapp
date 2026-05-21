import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';

class SingleTrainingPage extends StatefulWidget {
  const SingleTrainingPage({super.key});
  @override
  State<SingleTrainingPage> createState() => _SingleTrainingPageState();
}

class _SingleTrainingPageState extends State<SingleTrainingPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const kBg = Color(0xFF1B1B1B);
  static const kGreen = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBg,
      drawer: const ProfileDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            // Watermark pallone tenue sullo sfondo
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
                // Header condiviso (stesso delle altre pagine)
                AppHeader(
                  onHomeTap: () => context.go('/home'),
                  onBellTap: () => context.push('/notifications'),
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),

                // Back + Titolo + Subtitle
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, color: Colors.white),
                            onPressed: () => context.pop(),
                            splashRadius: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'WHAT KIND OF TRAINING',
                            style: GoogleFonts.oswald(
                              fontSize: 32,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              color: Color.fromRGBO(255, 253, 253, 1),
                              letterSpacing: .8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 52),
                          child: Text(
                            'Choose a workout for your training',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Griglia 2x2
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Wrap(
                        spacing: 28,
                        runSpacing: 26,
                        alignment: WrapAlignment.center,
                        children: [
                          _TrainingOption(
                            label: 'Kick',
                            iconBuilder: (c) => _IconKick(),
                          onTap: () =>context.push('/single/training/start'),
                          ),
                          _TrainingOption(
                            label: 'Pass',
                            iconBuilder: (c) => _IconPass(),
                           onTap: () => context.push('/single/training/start'),
                          ),
                          _TrainingOption(
                            label: 'Dribble',
                            iconBuilder: (c) => _IconDribble(),
                          onTap: () => context.push('/single/training/start'),
                          ),
                          _TrainingOption(
                            label: 'Ball Control',
                            iconBuilder: (c) => _IconBallControl(),
                            onTap: () => context.push('/single/training/start'),
                          ),
                        ],
                      ),
                    ),
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

/* ----------------------- UI bits ----------------------- */

class _TrainingOption extends StatelessWidget {
  final String label;
  final WidgetBuilder iconBuilder;
  final VoidCallback onTap;
  const _TrainingOption({required this.label, required this.iconBuilder, required this.onTap});

  static const kGreen = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          InkResponse(
            onTap: onTap,
            radius: 64,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: kGreen,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.85), width: 2),
                boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 3))],
              ),
              alignment: Alignment.center,
              child: iconBuilder(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---- Icone composte per simulare quelle del mock ---- */

class _IconKick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // scarpa + pallone piccolo in basso a destra
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.directions_run, color: Colors.white, size: 40),
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(Icons.sports_soccer, color: Colors.black87, size: 16),
          ),
        ),
      ],
    );
  }
}

class _IconPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // pallone + tre linee verticali di "pass"
    return SizedBox(
      width: 60,
      height: 44,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.sports_soccer, color: Colors.white, size: 32),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (_) => Container(
                  width: 4,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconDribble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // pallone + freccia curva
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.sports_soccer, color: Colors.white, size: 30),
        const SizedBox(width: 56, height: 56),
        Positioned(
          bottom: 4,
          child: Icon(Icons.redo, size: 30, color: Colors.white.withOpacity(0.95)),
        ),
      ],
    );
  }
}

class _IconBallControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // pallone + orologio in alto a destra
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.sports_soccer, color: Colors.white, size: 36),
        Positioned(
          top: -2,
          right: -2,
          child: Icon(Icons.access_time, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}
