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
                            'WHAT KIND OF TRAINING',
                            style: GoogleFonts.oswald(
                              fontSize: 26,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: .8,
                            ),
                          ),
                          Text(
                            'Choose a workout for your training',
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
                            _TrnBtn(
                              size: circle,
                              label: 'Kick',
                              icon: _IconKick(),
                              onTap: () => context.push('/single/training/start'),
                            ),
                            _TrnBtn(
                              size: circle,
                              label: 'Pass',
                              icon: _IconPass(),
                              onTap: () => context.push('/single/training/start'),
                            ),
                            _TrnBtn(
                              size: circle,
                              label: 'Dribble',
                              icon: _IconDribble(),
                              onTap: () => context.push('/single/training/start'),
                            ),
                            _TrnBtn(
                              size: circle,
                              label: 'Ball Control',
                              icon: _IconBallControl(),
                              onTap: () => context.push('/single/training/start'),
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

class _TrnBtn extends StatelessWidget {
  final double size;
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  const _TrnBtn({required this.size, required this.label, required this.icon, required this.onTap});

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
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}

class _IconKick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.directions_run, color: Colors.white, size: 40),
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(Icons.sports_soccer, color: Colors.black87, size: 14),
          ),
        ),
      ],
    );
  }
}

class _IconPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 40,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.sports_soccer, color: Colors.white, size: 28),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (_) => Container(
                  width: 3,
                  height: 16,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.sports_soccer, color: Colors.white, size: 26),
        const SizedBox(width: 46, height: 46),
        Positioned(
          bottom: 4,
          child: Icon(Icons.redo, size: 26, color: Colors.white.withOpacity(0.95)),
        ),
      ],
    );
  }
}

class _IconBallControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.sports_soccer, color: Colors.white, size: 32),
        const Positioned(
          top: -4,
          right: -4,
          child: Icon(Icons.access_time, color: Colors.white, size: 18),
        ),
      ],
    );
  }
}
