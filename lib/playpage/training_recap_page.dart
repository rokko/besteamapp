import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';

class TrainingRecapPage extends StatefulWidget {
  const TrainingRecapPage({super.key});
  @override
  State<TrainingRecapPage> createState() => _TrainingRecapPageState();
}

class _TrainingRecapPageState extends State<TrainingRecapPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1B1B1B),
      drawer: const ProfileDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              onHomeTap: () => context.go('/home'),
              onBellTap: () => context.push('/notifications'),
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),

            const SizedBox(height: 10),

            Text('RECAP',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                )),
            const SizedBox(height: 6),
            Text('GREAT!',
                style: GoogleFonts.oswald(
                  fontSize: 36,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                )),
            const SizedBox(height: 6),
            Text('You gained 5 SPEED POINTS',
                style: GoogleFonts.oswald(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.white.withOpacity(0.85),
                )),

            const SizedBox(height: 18),

            // PLAYER row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    width: 54, height: 54,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                    alignment: Alignment.center,
                    child: const Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PLAYER',
                          style: GoogleFonts.oswald(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('65',
                              style: GoogleFonts.oswald(
                                fontSize: 36,
                                color: const Color(0xFF2CC653),
                                fontWeight: FontWeight.w800,
                              )),
                          const SizedBox(width: 12),
                          _ProgressBar(value: 0.66),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // Glow verde + testo
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, -0.1),
                      radius: 0.75,
                      colors: [Color(0x332CC653), Colors.transparent],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'KEEP GOING ON!',
                    style: GoogleFonts.oswald(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Bottone "New training"
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () => context.go('/single/where'), // riparte il flusso
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2CC653),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: Text('New training',
                    style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  const _ProgressBar({required this.value});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 14,
      child: LayoutBuilder(builder: (_, c) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.centerLeft,
          child: Container(
            width: c.maxWidth * value,
            decoration: BoxDecoration(color: const Color(0xFF2E7AFB), borderRadius: BorderRadius.circular(20)),
          ),
        );
      }),
    );
  }
}
