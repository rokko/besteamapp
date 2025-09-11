import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';
import '../models/pitch.dart';

class DeviceSelectPage extends StatefulWidget {
  final Pitch pitch;
  const DeviceSelectPage({super.key, required this.pitch});
  @override
  State<DeviceSelectPage> createState() => _DeviceSelectPageState();
}

class _DeviceSelectPageState extends State<DeviceSelectPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _btn(String text, VoidCallback onTap) => OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      backgroundColor: const Color(0xFF2F2F2F),
      side: BorderSide(color: Colors.white.withOpacity(0.7), width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 18),
    ),
    child: Text(
      text,
      style: GoogleFonts.oswald(
        fontSize: 18, fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w800, color: Colors.white),
    ),
  );

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

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 18),
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
                    child: Text('DO YOU HAVE A DEVICE?',
                      style: GoogleFonts.oswald(
                        fontSize: 22, fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 2),
                    child: Text('Select an option',
                      style: GoogleFonts.montserrat(
                        fontSize: 12, fontStyle: FontStyle.italic,
                        color: Colors.white70)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _btn('BESTEAM DEVICE',
                      () => context.push('/pitch/scan', extra: widget.pitch)),
                  const SizedBox(height: 16),
                  _btn('No Device',
                      () => context.push('/single/training/start')), // bypass scan
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
