import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.oswald(fontSize: 24, color: Colors.white, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          '''
Privacy Policy for Besteam App.

This is a placeholder for the actual Privacy Policy.
Please insert the real legal terms and data handling rules here.

1. Data Collection
We collect the data you provide during registration.

2. Data Usage
We use your data to provide the best football experience.
          ''',
          style: GoogleFonts.montserrat(fontSize: 14, color: const Color(0xFFE0E3E0)),
        ),
      ),
    );
  }
}
