import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';
import '../models/pitch.dart';

class ScanNfcPage extends StatefulWidget {
  final Pitch pitch;
  const ScanNfcPage({super.key, required this.pitch});
  @override
  State<ScanNfcPage> createState() => _ScanNfcPageState();
}

class _ScanNfcPageState extends State<ScanNfcPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _scanning = false;
  bool _handled = false;
  final _controller = MobileScannerController(torchEnabled: false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startScan() async {
    setState(() {
      _scanning = true;
      _handled = false;
    });
  }

  void _onDetect(BarcodeCapture cap) {
    if (_handled) return;
    final code = cap.barcodes.isNotEmpty ? cap.barcodes.first.rawValue : null;
    _handled = true;
    // stop scan and go to Training Start
    _controller.stop();
    context.push('/single/training/start', extra: {'from': 'pitch', 'code': code});
  }

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
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 14),
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
                    child: Text('SCAN NFC',
                        style: GoogleFonts.oswald(
                          fontSize: 22, fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 2),
                    child: Text('Scan the NFC at the pitch',
                        style: GoogleFonts.montserrat(
                          fontSize: 12, fontStyle: FontStyle.italic, color: Colors.white70)),
                  ),
                ],
              ),
            ),

            // riquadro con QR/scanner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: _scanning
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: MobileScanner(
                            controller: _controller,
                            onDetect: _onDetect,
                          ),
                        )
                      : Center(
                          child: Icon(Icons.qr_code_2, color: Colors.white.withOpacity(0.8), size: 120),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _scanning ? null : _startScan,
              icon: const Icon(Icons.qr_code_scanner),
              label: Text('SCAN', style: GoogleFonts.oswald(fontStyle: FontStyle.italic, fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2CC653),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
