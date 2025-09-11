import 'package:besteamapp/home/home.dart';
import 'package:besteamapp/models/pitch.dart';
import 'package:besteamapp/onboarding/onboarding.dart';
import 'package:besteamapp/playpage/scan_nfc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:besteamapp/registrazione/registrazione.dart';
import 'package:besteamapp/notifiche/notification.dart';
import 'package:besteamapp/playpage/play_page.dart';
import 'package:besteamapp/playpage/single_where.dart';
import 'package:besteamapp/playpage/single_page_training.dart';
import 'package:besteamapp/playpage/training_start_page.dart';
import 'package:besteamapp/playpage/training_recap_page.dart';
import 'package:besteamapp/playpage/choose_pitch.dart';
import 'package:besteamapp/playpage/pitch_detail.dart';
import 'package:besteamapp/playpage/device_select.dart';
import 'splash/splash.dart';
void main() => runApp(const MyApp());

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),
    GoRoute(path: '/registrazione', builder: (_, __) => const RegistrationFlowPage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
     GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (_, __) => const NotificationsPage(),
    ),
    GoRoute(path: '/second', builder: (_, __) => const SecondPage()),
    GoRoute(path: '/play', builder: (_, __) => const PlayPage()), 
    GoRoute(path: '/single/where', builder: (_, __) => const SingleWherePage()),
    GoRoute(path: '/single/training', builder: (_, __) => const SingleTrainingPage()),
    GoRoute(path: '/single/training/start', builder: (_, __) => const TrainingStartPage()),
    GoRoute(path: '/single/training/recap', builder: (_, __) => const TrainingRecapPage()),
    GoRoute(path: '/pitch/list', builder: (_, __) => const ChoosePitchPage()),
GoRoute(
  path: '/pitch/detail',
  builder: (_, state) => PitchDetailPage(pitch: state.extra! as Pitch),
),
GoRoute(
  path: '/pitch/device',
  builder: (_, state) => DeviceSelectPage(pitch: state.extra! as Pitch),
),
GoRoute(
  path: '/pitch/scan',
  builder: (_, state) => ScanNfcPage(pitch: state.extra! as Pitch),
),


  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mia App',
      theme: ThemeData.light(useMaterial3: true),
      routerConfig: _router,
    );
  }
}

class HomePages extends StatelessWidget {
  const HomePages({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 120),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/second'),
              child: const Text('Vai alla seconda pagina'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seconda pagina')),
      body: const Center(child: Text('Ciao!')),
    );
  }
}
