import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';
import '../models/pitch.dart';

class PitchDetailPage extends StatefulWidget {
  final Pitch pitch;
  const PitchDetailPage({super.key, required this.pitch});

  @override
  State<PitchDetailPage> createState() => _PitchDetailPageState();
}

class _PitchDetailPageState extends State<PitchDetailPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final p = widget.pitch;
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

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    onPressed: () => context.pop(),
                    splashRadius: 22,
                  ),
                  const SizedBox(height: 2),
                   Padding(
                     padding: const EdgeInsets.only(left: 4),
                     child: Text('YOUR PITCH',
                       style: GoogleFonts.oswald(
                         fontSize: 32, fontStyle: FontStyle.italic,
                         fontWeight: FontWeight.w800, color: Color.fromRGBO(255, 253, 253, 1))),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 8, top: 2),
                     child: Text('info about your pitch',
                       style: GoogleFonts.montserrat(
                         fontSize: 20, fontStyle: FontStyle.italic,
                         color: Color.fromRGBO(255, 253, 253, 1))),
                   ),
                ],
              ),
            ),

             // immagine grande
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: Image.asset(
                   p.image, height: 190, width: 337, fit: BoxFit.cover,
                 ),
               ),
             ),
            const SizedBox(height: 12),

            // info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.title,
                                style: GoogleFonts.oswald(
                                  fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                            Text(p.subtitle, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white),
                      const SizedBox(width: 10),
                      Text('All day  ${p.hours}',
                          style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Continue
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () => context.push('/pitch/device', extra: p),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2CC653),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: Text('CONTINUE',
                    style: GoogleFonts.oswald(fontSize: 16, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
