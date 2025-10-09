import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

// widget riusabili
import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';
import '../widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Palette (come prima)
  static const kBg = Color(0xFF1B1B1B);
  static const kGreen = Color(0xFF2CC653);
  static const kMint  = Color(0xFFB7F0C4);
  static const kBlue  = Color(0xFF2E7AFB);
  static const kLine  = Color(0x192CC653);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HomePage.kBg,
      endDrawer: const ProfileDrawer(), // menu a bandiera
      body: SafeArea(
        child: Stack(
          children: [
            // linee verticali decorative
            Positioned.fill(child: CustomPaint(painter: _LinesPainter())),
            Column(
              children: [
                // HEADER condiviso (identico ovunque)
                AppHeader(
                  onHomeTap: () {}, // già su home
                  onBellTap: () => context.push('/notifications'),
                  onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),

                // --- CONTENUTO HOME (uguale a prima) ---
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _PlayerHeader(),
                        const SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'STATS',
                            style: GoogleFonts.oswald(
                              fontSize: 34,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Improve your avatar. Outdo yourself!',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Piramide “compact v2” (anti-overflow)
                        const Expanded(child: _StatsPyramidCompact()),

                        const SizedBox(height: 6),

                        // BOTTOM BAR condivisa
                        AppBottomBar(
                          onCenterTap: () => context.push('/play'), // <<< apre LET’S PLAY!
                        ),
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

/* ------------------ Player header ------------------ */

class _PlayerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 88, height: 88,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            'assets/images/avatar.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Colors.white70, size: 46),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PLAYER',
                  style: GoogleFonts.oswald(
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  )),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text('60',
                      style: GoogleFonts.oswald(
                        fontSize: 44, height: 1.0,
                        color: HomePage.kGreen, fontWeight: FontWeight.w800,
                      )),
                  const SizedBox(width: 12),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (_, c) {
                        final w = c.maxWidth;
                        const progress = 0.72;
                        return Container(
                          height: 16,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: w * progress,
                              decoration: BoxDecoration(color: HomePage.kBlue, borderRadius: BorderRadius.circular(20)),
                            ),
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
      ],
    );
  }
}

/* --------------- Piramide compact v2 ---------------- */

/* --------------- Piramide compact v2 ---------------- */
class _StatsPyramidCompact extends StatelessWidget {
  const _StatsPyramidCompact();
  
  // Dimensioni card
  static const double cardW = 160.0;  // larghezza singola card
  static const double cardH = 54.0;   // altezza card
  static const double gap = 4.0;      // gap minimo tra card affiancate
  static const double vGap = 12.0;    // gap verticale tra le righe

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 1. GOALKEEPING (singola, centrata)
        _StatCard(
          width: cardW,
          height: cardH,
          title: 'GOALKEEPING',
          progress: 0.58,
          iconData: Icons.sports_soccer,
        ),
        SizedBox(height: vGap),
        
        // 2. PHYSICAL + TECHNICAL (coppia)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StatCard(
              width: cardW,
              height: cardH,
              title: 'PHYSICAL',
              progress: 0.20,
              iconData: Icons.fitness_center,
            ),
            SizedBox(width: gap),
            _StatCard(
              width: cardW,
              height: cardH,
              title: 'TECHNICAL',
              progress: 0.62,
              iconData: Icons.precision_manufacturing,
            ),
          ],
        ),
        SizedBox(height: vGap),
        
        // 3. SPEED (singola, centrata)
        _StatCard(
          width: cardW,
          height: cardH,
          title: 'SPEED',
          progress: 0.42,
          iconData: Icons.speed,
        ),
        SizedBox(height: vGap),
        
        // 4. KICK + PASS (coppia)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StatCard(
              width: cardW,
              height: cardH,
              title: 'KICK',
              progress: 0.30,
              iconData: Icons.sports,
            ),
            SizedBox(width: gap),
            _StatCard(
              width: cardW,
              height: cardH,
              title: 'PASS',
              progress: 0.82,
              iconData: Icons.arrow_forward,
            ),
          ],
        ),
        SizedBox(height: vGap),
        
        // 5. MENTAL (singola, centrata)
        _StatCard(
          width: cardW,
          height: cardH,
          title: 'MENTAL',
          progress: 0.45,
          iconData: Icons.psychology,
        ),
      ],
    );
  }
}

// Widget per ogni singola card statistica
class _StatCard extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final double progress;
  final IconData iconData;

  const _StatCard({
    required this.width,
    required this.height,
    required this.title,
    required this.progress,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: HomePage.kMint,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Riga con icona e titolo
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(iconData, size: 16, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.4),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black87),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotchedCard extends StatelessWidget {
  final double width, height;
  final String title; final double progress;
  final bool notchTop, notchBottom;
  final double notchW, notchH;

  const _NotchedCard({
    required this.width, required this.height, required this.title, required this.progress,
    required this.notchTop, required this.notchBottom, required this.notchW, required this.notchH,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height + (notchTop ? notchH : 0) + (notchBottom ? notchH : 0),
      child: Stack(
        alignment: Alignment.center, clipBehavior: Clip.none,
        children: [
          Positioned(
            top: notchTop ? notchH : 0, bottom: notchBottom ? notchH : 0, left: 0, right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: HomePage.kMint,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
              ),
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Row(
                children: [
                  Container(
                    width: 30, height: 30,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: const Icon(Icons.fitness_center, color: Colors.black87, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.oswald(
                            fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700, color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        LayoutBuilder(
                          builder: (_, c) {
                            final w = c.maxWidth;
                            return Container(
                              height: 10,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: w * progress,
                                  decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (notchTop) Positioned(top: 0, child: _Notch(width: notchW, height: notchH)),
          if (notchBottom) Positioned(bottom: 0, child: _Notch(width: notchW, height: notchH)),
        ],
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  final double width, height;
  const _Notch({required this.width, required this.height});
  @override
  Widget build(BuildContext context) => Container(
    width: width, height: height,
    decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(3)),
  );
}

class _ConnectorVertical extends StatelessWidget {
  final double height, thickness;
  const _ConnectorVertical({required this.height, required this.thickness});
  @override
  Widget build(BuildContext context) => Container(
    width: thickness, height: height,
    decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(thickness / 2)),
  );
}

class _ForkConnector extends StatelessWidget {
  final double totalWidth, arm, thickness;
  const _ForkConnector({required this.totalWidth, required this.arm, required this.thickness});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: totalWidth, height: 14,
      child: Stack(
        alignment: Alignment.topCenter, clipBehavior: Clip.none,
        children: [
          Container(width: thickness, height: 14,
            decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(thickness / 2))),
          Positioned(
            bottom: 0, left: (totalWidth / 2) - arm - thickness / 2,
            child: Container(width: arm, height: thickness,
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(thickness / 2))),
          ),
          Positioned(
            bottom: 0, right: (totalWidth / 2) - arm - thickness / 2,
            child: Container(width: arm, height: thickness,
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(thickness / 2))),
          ),
        ],
      ),
    );
  }
}

/* ----------------- Sfondo: linee verdi ---------------- */

class _LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = HomePage.kLine..strokeWidth = 1.2;
    final xs = [size.width * .18, size.width * .34, size.width * .68, size.width * .84];
    for (final x in xs) canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
