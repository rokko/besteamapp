import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistrationFlowPage extends StatefulWidget {
  const RegistrationFlowPage({super.key});

  @override
  State<RegistrationFlowPage> createState() => _RegistrationFlowPageState();
}

class _RegistrationFlowPageState extends State<RegistrationFlowPage> {
  // Palette (campionata dagli screenshot)
  static const kBg = Color(0xFF1B1B1B);
  static const kPrimary = Color(0xFF2CC653);
  static const kInput = Color(0xFF606060);
  static const kTextLight = Color(0xFFE0E3E0);

  final _controller = PageController();
  int _index = 0;

  // ---- STEP 1 ----
  final _form1 = GlobalKey<FormState>();
  final _nick = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _acceptTos = false;
  bool _newsletter = false;

  // ---- STEP 2 ----
  final _form2 = GlobalKey<FormState>();
  final _nationality = TextEditingController();
  final _country = TextEditingController();
  final _birthCtrl = TextEditingController();
  final _role = TextEditingController();
  String? _gender;
  DateTime? _birthDate;

  // Tipografia
  TextStyle get _title =>
      GoogleFonts.oswald(fontSize: 28, color: Colors.white, fontStyle: FontStyle.italic);
  TextStyle get _label => GoogleFonts.oswald(fontSize: 22, color: Colors.white);
  TextStyle get _body => GoogleFonts.montserrat(fontSize: 14, color: kTextLight);

  InputDecoration _field({
    required String hint,
    bool isReadOnly = false,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.montserrat(
        fontStyle: FontStyle.italic,
        color: Colors.white.withOpacity(0.6),
      ),
      filled: true,
      fillColor: kInput,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(color: kInput),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(color: Colors.white, width: 1),
      ),
    );
  }

  // Utils
  void _goBack() {
    if (_index == 0) {
      if (Navigator.of(context).canPop()) context.pop();
    } else {
      _controller.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  void _next() async {
    if (_index == 0) {
      if (!(_form1.currentState?.validate() ?? false)) return;
      _controller.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    } else {
      if (!(_form2.currentState?.validate() ?? false)) return;
      // TODO: invio dati di registrazione
      context.go('/home');
    }
  }

  // Pickers (step 2)
  Future<void> _pickCountry() async {
    final list = const ['Italy', 'France', 'Spain', 'Germany', 'United Kingdom'];
    final sel = await _showBottomPicker('Select a country', list);
    if (sel != null) _country.text = sel;
    setState(() {});
  }

  Future<void> _pickRole() async {
    final list = const ['Striker', 'Midfielder', 'Defender', 'Goalkeeper'];
    final sel = await _showBottomPicker('Select a role', list);
    if (sel != null) _role.text = sel;
    setState(() {});
  }

  Future<void> _pickGender() async {
    final list = const ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
    final sel = await _showBottomPicker('Select gender', list);
    if (sel != null) {
      _gender = sel;
    }
    setState(() {});
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final initial = _birthDate ?? DateTime(now.year - 18, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (ctx, child) {
        // dark theme + verde
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: kPrimary,
              surface: kBg,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: kBg,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _birthDate = picked;
      _birthCtrl.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      setState(() {});
    }
  }

  Future<String?> _showBottomPicker(String title, List<String> options) async {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: kBg,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Text(title, style: GoogleFonts.oswald(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
              const Divider(color: Colors.white24, height: 1),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.white12, height: 1),
                  itemBuilder: (_, i) => ListTile(
                    title: Text(options[i], style: _body.copyWith(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: kPrimary),
                    onTap: () => Navigator.of(ctx).pop(options[i]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _nick.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();

    _nationality.dispose();
    _country.dispose();
    _birthCtrl.dispose();
    _role.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == 1;
    final buttonLabel = isLast ? 'START >' : 'NEXT >';

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: _goBack,
        ),
        centerTitle: true,
        title: Text(
          _index == 0 ? 'Set your account' : 'Set your datas',
          style: _title,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _index = i),
                children: [
                  // ----------------- STEP 1 -----------------
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Form(
                      key: _form1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nickname', style: _label),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _nick,
                            style: _body.copyWith(color: Colors.white),
                            decoration: _field(hint: 'Best1234_'),
                            validator: (v) =>
                                (v == null || v.trim().length < 3) ? 'Inserisci un nickname valido' : null,
                          ),
                          const SizedBox(height: 8),
                          _Rules(items: const [
                            'non meno di 3 caratteri',
                            'minimo 3 lettere',
                            'non più di 16 caratteri',
                            'Max 4 numeri',
                            'caratteri speciali ammessi [ _ , - ]',
                          ]),
                          const SizedBox(height: 18),

                          Text('Email', style: _label),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            style: _body.copyWith(color: Colors.white),
                            decoration: _field(hint: 'bestemail@email.com'),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Inserisci l’email';
                              final ok = RegExp(r'^\S+@\S+\.\S+$').hasMatch(v.trim());
                              return ok ? null : 'Email non valida';
                            },
                          ),
                          const SizedBox(height: 12),

                          _CircleToggleRow(
                            value: _acceptTos,
                            onChanged: (val) => setState(() => _acceptTos = val),
                            child: RichText(
                              text: TextSpan(
                                style: _body,
                                children: [
                                  const TextSpan(text: 'I accept the '),
                                  TextSpan(
                                      text: 'Terms and conditions',
                                      style: _body.copyWith(color: kPrimary)),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                      text: 'Privacy Policy', style: _body.copyWith(color: kPrimary)),
                                  const TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _CircleToggleRow(
                            value: _newsletter,
                            onChanged: (val) => setState(() => _newsletter = val),
                            child: Text('I agree to subscribe to Besteam newsletter.', style: _body),
                          ),
                          const SizedBox(height: 18),

                          Text('Password', style: _label),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            style: _body.copyWith(color: Colors.white),
                            decoration: _field(hint: 'Bestpassword1234!'),
                            validator: (v) => (v == null || v.length < 8) ? 'Password troppo corta' : null,
                          ),
                          const SizedBox(height: 8),
                          _Rules(items: const [
                            'Min 8 caratteri',
                            'Max 15 caratteri',
                            'Almeno un carattere speciale (!,?,&)',
                            'Min un numero',
                            'Almeno un carattere maiuscolo',
                          ]),
                          const SizedBox(height: 18),

                          Text('Confirm Password', style: _label),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _confirm,
                            obscureText: true,
                            style: _body.copyWith(color: Colors.white),
                            decoration: _field(hint: 'Bestpassword1234_'),
                            validator: (v) => (v != _password.text) ? 'Le password non coincidono' : null,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // ----------------- STEP 2 (replica screenshot) -----------------
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Form(
                      key: _form2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nationality (campo libero)
                          Text('Nationality', style: _label),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _nationality,
                            style: _body.copyWith(color: Colors.white),
                            decoration: _field(hint: 'Nationality'),
                            validator: (v) => (v == null || v.isEmpty) ? 'Richiesto' : null,
                          ),
                          const SizedBox(height: 24),

                          // Where are you playing from? (selezione con freccia verde destra)
                          Text('Where are you playing from?', style: _label),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _country,
                            readOnly: true,
                            style: _body.copyWith(color: Colors.white),
                            decoration: _field(
                              hint: 'Select a country',
                              suffix: const Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: Icon(Icons.chevron_right, color: kPrimary),
                              ),
                            ),
                            onTap: _pickCountry,
                            validator: (v) => (v == null || v.isEmpty) ? 'Richiesto' : null,
                          ),
                          const SizedBox(height: 24),

                          // Birth date + Gender (affiancati)
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Birth date', style: _label),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _birthCtrl,
                                      readOnly: true,
                                      style: _body.copyWith(color: Colors.white),
                                      decoration: _field(hint: 'dd/mm/yyyy'),
                                      onTap: _pickBirthDate,
                                      validator: (v) => (v == null || v.isEmpty) ? 'Richiesto' : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Gender', style: _label),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      readOnly: true,
                                      controller: TextEditingController(text: _gender ?? ''),
                                      style: _body.copyWith(color: Colors.white),
                                      decoration: _field(
                                        hint: 'Select the gender',
                                        suffix: const Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: Icon(Icons.expand_more, color: kPrimary),
                                        ),
                                      ),
                                      onTap: _pickGender,
                                      validator: (_) => (_gender == null) ? 'Richiesto' : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Favorite role (selezione con freccia verde destra)
                          Text('Favorite role', style: _label),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _role,
                            readOnly: true,
                            style: _body.copyWith(color: Colors.white),
                            decoration: _field(
                              hint: 'Select a role',
                              suffix: const Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: Icon(Icons.chevron_right, color: kPrimary),
                              ),
                            ),
                            onTap: _pickRole,
                            validator: (v) => (v == null || v.isEmpty) ? 'Richiesto' : null,
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Bottom: pulsante + indicatori
            Padding(
              padding: EdgeInsets.fromLTRB(24, 8, 24, 16 + MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        textStyle: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.w700),
                        elevation: 0,
                      ),
                      child: Text(buttonLabel),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Dots: attivo pieno verde, inattivo anello bianco
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (i) {
                      final selected = i == _index;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected ? kPrimary : Colors.transparent,
                          border: Border.all(
                            color: selected ? kPrimary : Colors.white70,
                            width: 2,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widget di servizio per le regole (step 1)
class _Rules extends StatelessWidget {
  final List<String> items;
  const _Rules({required this.items});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.montserrat(fontSize: 14, color: Colors.white);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 8),
                    child: Icon(Icons.circle, size: 6, color: _RegistrationFlowPageState.kPrimary),
                  ),
                  Expanded(child: Text(t, style: style)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// --- Toggle circolare custom (step 1)
class _CircleToggleRow extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget child;
  const _CircleToggleRow({required this.value, required this.onChanged, required this.child});

  @override
  Widget build(BuildContext context) {
    const kPrimary = _RegistrationFlowPageState.kPrimary;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kPrimary, width: 2),
              color: Colors.transparent,
            ),
            alignment: Alignment.center,
            child: value
                ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: kPrimary, shape: BoxShape.circle))
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(child: child),
        ],
      ),
    );
  }
}
