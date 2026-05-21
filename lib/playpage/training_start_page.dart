import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_header.dart';
import '../widgets/profile_drawer.dart';

class TrainingStartPage extends StatefulWidget {
  const TrainingStartPage({super.key});
  @override
  State<TrainingStartPage> createState() => _TrainingStartPageState();
}

enum _TState { idle, running, paused, finished }

class _TrainingStartPageState extends State<TrainingStartPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const kBg = Color(0xFF1B1B1B);
  static const kGreen = Color(0xFF2CC653);

  // TIMER (02:00.00)
  Timer? _timer;
  int _msLeft = 2 * 60 * 1000;
  _TState _state = _TState.idle;

  // METRICHE (esempio: Bounce, Drop)
  int _bounce = 0;
  int _drops = 0;
  static const int _bounceGoal = 80;
  static const int _dropGoal = 5;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    if (_state == _TState.running) return;
    setState(() => _state = _TState.running);
    _timer?.cancel();
    int tick = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (t) {
      if (_msLeft <= 0) {
        t.cancel();
        setState(() => _state = _TState.finished);
        return;
      }
      setState(() => _msLeft -= 10);
      tick += 10;

      // Simulazione progress metrica
      if (tick % 1000 == 0 && _bounce < _bounceGoal) _bounce++;
      if (tick % 4000 == 0 && _drops < _dropGoal) _drops++;
    });
  }

  void _pause() async {
    final ok = await _showPauseDialog(context);
    if (ok == true) {
      _timer?.cancel();
      setState(() => _state = _TState.paused);
    }
  }

  void _stop() {
    _timer?.cancel();
    setState(() => _state = _TState.finished);
    context.push('/single/training/recap');
  }

  String _fmt(int ms) {
    final totalCs = (ms / 10).floor();
    final m = (totalCs ~/ 6000).toString().padLeft(2, '0');
    final s = ((totalCs % 6000) ~/ 100).toString().padLeft(2, '0');
    final cs = (totalCs % 100).toString().padLeft(2, '0');
    return '$m:$s.$cs';
  }

  @override
  Widget build(BuildContext context) {
    final running = _state == _TState.running;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBg,
      drawer: const ProfileDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            if (running) Positioned.fill(child: CustomPaint(painter: _StripesPainter())),

            Column(
              children: [
                AppHeader(
                  onHomeTap: () => context.go('/home'),
                  onBellTap: () => context.push('/notifications'),
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 12),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                          onPressed: () => context.pop(),
                          splashRadius: 22,
                        ),
                      ),
                      Text(
                        "LET’S START TRAINING",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromRGBO(255, 253, 253, 1),
                          letterSpacing: .8,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _fmt(_msLeft),
                      style: GoogleFonts.oswald(
                        fontSize: 34,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                _MetricRow(
                  title: 'Bounce Count',
                  trailingText: '$_bounce/$_bounceGoal',
                ),
                const SizedBox(height: 12),
                _MetricRow(
                  title: 'Ball Drop',
                  trailingText: '$_drops/$_dropGoal',
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: (_state == _TState.idle || _state == _TState.paused)
                        ? _SwipeToStart(
                            key: const ValueKey('swipe'),
                            label: _state == _TState.idle ? 'Swipe to start' : 'Swipe to resume',
                            onComplete: _start,
                          )
                        : Row(
                            key: const ValueKey('buttons'),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _PillButton(
                                label: 'Pause',
                                bg: const Color(0xFFEDEDED),
                                fg: Colors.black87,
                                onTap: _pause,
                              ),
                              _PillButton(
                                label: 'Stop',
                                bg: const Color(0xFFE74C3C),
                                fg: Colors.white,
                                onTap: _stop,
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

class _MetricRow extends StatelessWidget {
  final String title;
  final String trailingText;
  const _MetricRow({required this.title, required this.trailingText});

  static const kGreen = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  Row(
                    children: const [
                      Icon(Icons.fitness_center, size: 16, color: Colors.white70),
                      SizedBox(width: 6),
                      Icon(Icons.sports_soccer, size: 16, color: Colors.white70),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: kGreen,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 3))],
              ),
              alignment: Alignment.center,
              child: Text(
                trailingText,
                style: GoogleFonts.oswald(
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  const _PillButton({required this.label, required this.bg, required this.fg, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label, style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _SwipeToStart extends StatefulWidget {
  final String label;
  final VoidCallback onComplete;
  const _SwipeToStart({super.key, required this.label, required this.onComplete});
  @override
  State<_SwipeToStart> createState() => _SwipeToStartState();
}

class _SwipeToStartState extends State<_SwipeToStart> with SingleTickerProviderStateMixin {
  double _pos = 0;
  late AnimationController _ac;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 220))
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final trackW = c.maxWidth;
      const trackH = 44.0;
      const pad = 6.0;
      const thumb = 32.0;
      final max = trackW - pad * 2 - thumb;

      return Container(
        width: trackW,
        height: trackH,
        decoration: BoxDecoration(
          color: const Color(0xFFBDBDBD),
          borderRadius: BorderRadius.circular(trackH / 2),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87.withOpacity(0.75),
                ),
              ),
            ),
            Positioned(
              left: pad + _pos,
              child: GestureDetector(
                onHorizontalDragUpdate: (d) {
                  setState(() => _pos = (_pos + d.delta.dx).clamp(0, max));
                },
                onHorizontalDragEnd: (_) {
                  if (_pos >= max * 0.9) {
                    setState(() => _pos = max);
                    widget.onComplete();
                  } else {
                    _ac
                      ..value = _pos / max
                      ..animateTo(0, curve: Curves.easeOut);
                    _ac.addListener(() {
                      setState(() => _pos = _ac.value * max);
                    });
                  }
                },
                child: Container(
                  width: thumb,
                  height: thumb,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.double_arrow, size: 20, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _StripesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = Colors.transparent;
    canvas.drawRect(Offset.zero & size, bg);

    final stripe = Paint()..color = const Color(0xFF5A1818).withOpacity(0.35);
    final w = size.width / 6;
    for (int i = 0; i < 6; i += 2) {
      canvas.drawRect(Rect.fromLTWH(i * w, 0, w, size.height), stripe);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Future<bool?> _showPauseDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (ctx) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 260,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
            decoration: BoxDecoration(
              color: const Color(0xFF232323),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Pause training?',
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _DialogGreenButton(label: 'YES', onTap: () => Navigator.of(ctx).pop(true)),
                    _DialogGreenButton(label: 'NO', onTap: () => Navigator.of(ctx).pop(false)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _DialogGreenButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _DialogGreenButton({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2CC653),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(label, style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }
}
