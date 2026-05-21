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
        child: Stack(
          children: [
            // Sfondo gradiente intero
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Color(0xFF1C2C20), Color(0xFF2CC653)],  // verde scuro -> verde brillante
                  ),
                ),
              ),
            ),
            Column(
              children: [
                // Header condiviso (uguale alle altre pagine)
                AppHeader(
                  onHomeTap: () => context.go('/home'),
                  onBellTap: () => context.push('/notifications'),
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),

                // Titolo con freccia back
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 8),
                  child: SizedBox(
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.chevron_left, color: Colors.white),
                            onPressed: () => context.pop(),
                            splashRadius: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 56),
                          child: Text(
                            "LET'S PLAY!",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.oswald(
                              fontSize: 26,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Bottoni centrati verticalmente nel restante spazio
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _PlayButton(
                          label: 'SINGLE PLAYER',
                          onTap: () => context.push('/single/where'),
                        ),
                        const SizedBox(height: 20),
                        _PlayButton(
                          label: 'PITCH',
                          onTap: () => context.push('/pitch/list'),
                        ),
                        const SizedBox(height: 100), // sposta leggermente in alto per bilanciare l'aspetto visivo
                      ],
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

class _PlayButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PlayButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFF262626),
        side: BorderSide(color: Colors.white.withOpacity(0.35), width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 22),
      ),
      child: Text(
        label,
        style: GoogleFonts.oswald(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: .8,
        ),
      ),
    );
  }
}
