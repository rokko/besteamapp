class Pitch {
  final String id;
  final String title;
  final String subtitle;
  final String image; // asset or network
  final String hours;

  const Pitch({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.hours,
  });
}
