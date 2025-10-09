import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  static const _menuBg   = Color(0xFF2A2A2A);
  static const _itemText = Color(0xFFBEBEBE);
  static const _bullet   = Color(0xFFE6E6E6);
  static const _green    = Color(0xFF2CC653);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 268,
      backgroundColor: _menuBg,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: const BoxDecoration(color: _green, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: const Icon(Icons.person, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Text('Your Profile',
                      style: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, thickness: 1, indent: 46, color: Color(0xFF6F6F6F)),
              const SizedBox(height: 22),
              const _Item('Your devices'),
              const SizedBox(height: 16),
              const _Item('Settings'),
              const SizedBox(height: 16),
              const _Item('Wallet'),
              const SizedBox(height: 16),
              const _Item('Update'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String label;
  const _Item(this.label);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Row(
          children: [
        
            Text(label, style: GoogleFonts.montserrat(fontSize: 16, color: ProfileDrawer._itemText)),
          ],
        ),
      ),
    );
  }
}
