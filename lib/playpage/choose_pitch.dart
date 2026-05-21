import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';
import '../models/pitch.dart';

class ChoosePitchPage extends StatefulWidget {
  const ChoosePitchPage({super.key});
  @override
  State<ChoosePitchPage> createState() => _ChoosePitchPageState();
}

class _ChoosePitchPageState extends State<ChoosePitchPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // mock data
  final _items = const [
    Pitch(id: 'p1', title: 'List Item', subtitle: 'Secondary Text', image: 'assets/images/pitch.jpg', hours: '8:00 - 23:00'),
    Pitch(id: 'p2', title: 'List Item', subtitle: 'Secondary Text', image: 'assets/images/pitch.jpg', hours: '8:00 - 23:00'),
    Pitch(id: 'p3', title: 'List Item', subtitle: 'Secondary Text', image: 'assets/images/pitch.jpg', hours: '8:00 - 23:00'),
    Pitch(id: 'p4', title: 'List Item', subtitle: 'Secondary Text', image: 'assets/images/pitch.jpg', hours: '8:00 - 23:00'),
  ];

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

            // back + title
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
                     child: Text('CHOOSE YOUR PITCH',
                       style: GoogleFonts.oswald(
                         fontSize: 32, fontStyle: FontStyle.italic,
                         fontWeight: FontWeight.w800, color: Color.fromRGBO(255, 253, 253, 1))),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 8, top: 2),
                     child: Text('select your favorite pitch',
                       style: GoogleFonts.montserrat(
                         fontSize: 20, fontStyle: FontStyle.italic,
                         color: Color.fromRGBO(255, 253, 253, 1))),
                   ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final p = _items[i];
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => context.push('/pitch/detail', extra: p),
                    child: Container(
                      height: 74,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.place_outlined, color: Colors.white, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.title,
                                  style: GoogleFonts.oswald(
                                    fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                                const SizedBox(height: 2),
                                Text(p.subtitle,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12, color: Colors.white70)),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              p.image, width: 86, height: 56, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 86, height: 56, color: Colors.black26,
                                child: const Icon(Icons.image, color: Colors.white54),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
