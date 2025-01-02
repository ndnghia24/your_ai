class EmailStyle {
  static const tone = EmailTone();
  static const formality = EmailFormality();
  static const length = EmailLength();
  static const language = EmailLanguage();

  final String lengthData;
  final String formalityData;
  final String toneData;
  final String languageData;

  EmailStyle({
    required this.lengthData,
    required this.formalityData,
    required this.toneData,
    required this.languageData,
  });
}

class EmailTone {
  const EmailTone();

  final witty = 'witty';
  final direct = 'direct';
  final personable = 'personable';
  final informational = 'informational';
  final friendly = 'friendly';
  final confident = 'confident';
  final sincere = 'sincere';
  final enthusiastic = 'enthusiastic';
  final optimistic = 'optimistic';
  final concerned = 'concerned';
  final empathetic = 'empathetic';
}

class EmailFormality {
  const EmailFormality();

  final casual = 'casual';
  final neutral = 'neutral';
  final formal = 'formal';
}

class EmailLength {
  const EmailLength();

  final short = 'short';
  final medium = 'medium';
  final long = 'long';
}

class EmailLanguage {
  const EmailLanguage();

  final vietnamese = 'vietnamese';
  final english = 'english';
}
