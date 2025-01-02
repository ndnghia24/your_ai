class Language {
  final String locale;
  final String name;
  final String localeName;
  const Language({
    required this.locale,
    required this.name,
    required this.localeName,
  });
}

const List<Language> supportedLanguages = [
  const Language(locale: 'en', name: 'English', localeName: 'English'),
  const Language(locale: 'es', name: 'Spanish', localeName: 'Español'),
  const Language(locale: 'fr', name: 'French', localeName: 'Français'),
  const Language(locale: 'de', name: 'German', localeName: 'Deutsch'),
  const Language(locale: 'it', name: 'Italian', localeName: 'Italiano'),
  const Language(locale: 'pt', name: 'Portuguese', localeName: 'Português'),
  const Language(locale: 'ru', name: 'Russian', localeName: 'Русский'),
  const Language(locale: 'ja', name: 'Japanese', localeName: '日本語'),
  const Language(locale: 'ko', name: 'Korean', localeName: '한국어'),
  const Language(locale: 'zh', name: 'Chinese', localeName: '中文'),
  const Language(locale: 'ar', name: 'Arabic', localeName: 'العربية'),
  const Language(locale: 'hi', name: 'Hindi', localeName: 'हिन्दी'),
  const Language(locale: 'tr', name: 'Turkish', localeName: 'Türkçe'),
  const Language(locale: 'vi', name: 'Vietnamese', localeName: 'Tiếng Việt'),
  const Language(locale: 'th', name: 'Thai', localeName: 'ไทย'),
  const Language(locale: 'nl', name: 'Dutch', localeName: 'Nederlands'),
  const Language(locale: 'pl', name: 'Polish', localeName: 'Polski'),
  const Language(locale: 'id', name: 'Indonesian', localeName: 'Bahasa Indonesia'),
  const Language(locale: 'ro', name: 'Romanian', localeName: 'Română'),
  const Language(locale: 'cs', name: 'Czech', localeName: 'Čeština'),
  const Language(locale: 'hu', name: 'Hungarian', localeName: 'Magyar'),
  const Language(locale: 'sv', name: 'Swedish', localeName: 'Svenska'),
  const Language(locale: 'da', name: 'Danish', localeName: 'Dansk'),
  const Language(locale: 'fi', name: 'Finnish', localeName: 'Suomi'),
  const Language(locale: 'el', name: 'Greek', localeName: 'Ελληνικά'),
  const Language(locale: 'no', name: 'Norwegian', localeName: 'Norsk'),
  const Language(locale: 'he', name: 'Hebrew', localeName: 'עברית'),
  const Language(locale: 'fa', name: 'Persian', localeName: 'فارسی'),
  const Language(locale: 'sr', name: 'Serbian', localeName: 'Српски'),
  const Language(locale: 'hr', name: 'Croatian', localeName: 'Hrvatski'),
];


  