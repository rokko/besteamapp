import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_bar.dart'; // aggiungi questa riga
import '../widgets/app_header.dart'; // aggiungi questa riga
import '../widgets/profile_drawer.dart'; // importa il drawer

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  // === PALETTE (uguale alla Home) ===
  static const kBg = Color(0xFF1B1B1B);
  static const kHeaderBg = Color(0xFF222222);
  static const kGreen = Color(0xFF2CC653);
  static const kLine = Color(0x192CC653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      endDrawer:
          const ProfileDrawer(), // se vuoi anche qui il drawer come nella Home: aggiungi drawer: const _ProfileDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            // Decor: linee verticali verdi trasparenti
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // HEADER curvo con icone (stesso stile)
                Builder(
                  builder: (headerContext) => AppHeader(
                    onHomeTap: () => context.go('/home'),
                    onBellTap: () {},
                    onMenuTap: () => Scaffold.of(headerContext).openEndDrawer(),
                  ),
                ),
                // RIGA: back + titolo centrato "NOTIFICATION"
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        splashRadius: 22,
                      ),
                      const Spacer(),
                      Text(
                        'NOTIFICATION',
                        style: GoogleFonts.oswald(
                          fontSize: 26,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const Spacer(),
                      // spazio per allineare il titolo proprio al centro
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // LISTA notifiche
                const Expanded(child: _NotificationsList()),

                // Bottom bar (stessa della Home)
                const SizedBox(height: 6),
                AppBottomBar(
                  onCenterTap: () {
                    // Azione desiderata, ad esempio:
                    Navigator.of(context).pushNamed('/play');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ===================== WIDGETS ===================== */

class _CurvedHeader extends StatelessWidget {
  const _CurvedHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // più compatto, come nello screen
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: _BottomCurveClipper(),
              child: Container(color: NotificationsPage.kHeaderBg),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: const [
                // (iconcine top come nello stile)
                Icon(Icons.home_outlined, color: Colors.white, size: 24),
                SizedBox(width: 16),
                Icon(
                  Icons.notifications,
                  color: NotificationsPage.kGreen,
                  size: 24,
                ),
                Spacer(),
                Icon(
                  Icons.sports_soccer,
                  color: NotificationsPage.kGreen,
                  size: 24,
                ),
                SizedBox(width: 16),
                Icon(Icons.menu, color: Colors.white, size: 26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList();

  @override
  Widget build(BuildContext context) {
    final items = <_Notif>[
      _Notif(
        title: 'Start a new experience!',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        unread: true,
      ),
      _Notif(
        title: 'Welcome!',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        unread: false,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _NotificationTile(item: items[i]),
    );
  }
}

class _Notif {
  final String title;
  final String body;
  final bool unread;
  const _Notif({required this.title, required this.body, required this.unread});
}

class _NotificationTile extends StatelessWidget {
  final _Notif item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    // fascia leggermente più scura sotto ogni titolo (come nel tuo shot)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white.withOpacity(0.05),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // bullet per UNREAD
              Padding(
                padding: const EdgeInsets.only(top: 7.5, right: 10),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: item.unread ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: item.unread ? Colors.white : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
              ),
              // testo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.oswald(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.body,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/* =============== Bottom bar come Home ============== */

/* ================ Helpers grafici ================== */

class _LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = NotificationsPage.kLine
      ..strokeWidth = 1.2;
    final xs = [
      size.width * .18,
      size.width * .34,
      size.width * .68,
      size.width * .84,
    ];
    for (final x in xs) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height, w = size.width;
    return Path()
      ..lineTo(0, h - 32)
      ..quadraticBezierTo(w * 0.5, h, w, h - 32)
      ..lineTo(w, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
