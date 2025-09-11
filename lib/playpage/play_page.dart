import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});
  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const kBg = Color(0xFF1B1B1B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBg,
      drawer: const ProfileDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Header condiviso (uguale alle altre pagine)
            AppHeader(
              onHomeTap: () => context.go('/home'),
              onBellTap: () => context.push('/notifications'),
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),

            // Titolo con freccia back
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    onPressed: () => context.pop(),
                    splashRadius: 22,
                  ),
                  const Spacer(),
                  Text(
                    "LET'S PLAY!",
                    style: GoogleFonts.oswald(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: .8,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Corpo con gradiente verde + 2 bottoni
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Color(0xFF1F3C25), Color(0xFF29A146)],  // verde scuro -> verde
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      _PlayButton(
  label: 'SINGLE PLAYER',
  onTap: () => context.push('/single/where'),
),
                      const SizedBox(height: 18),
                     _PlayButton(
  label: 'PITCH',
  onTap: () => context.push('/pitch/list'),
),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PlayButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFF2F2F2F),
        side: BorderSide(color: Colors.white.withOpacity(0.7), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
      child: Text(
        label,
        style: GoogleFonts.oswald(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: .6,
        ),
      ),
    );
  }
}
