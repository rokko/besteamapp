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
                  child: SizedBox(
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                            splashRadius: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 56),
                          child: Text(
                            'NOTIFICATION',
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
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(color: Colors.white12, height: 1),
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
          color: item.unread ? Colors.white.withOpacity(0.05) : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                child: item.unread
                    ? Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
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


