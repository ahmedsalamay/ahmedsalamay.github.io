import 'package:fimto_frame/repository/local/language_local_repository.dart';
import 'package:flutter/material.dart';

class Language extends ChangeNotifier {
  final LanguageLocalRepository languageLocalRepository =
      LanguageLocalRepository();

  static const String arabicCode = 'ar';
  static const String englishCode = 'en';

  Locale _currentLocale = const Locale(Language.englishCode);
  Locale get currentLocale => _currentLocale;

  set newLocale(String localeCode) {
    if (localeCode != arabicCode && localeCode != englishCode) {
      return;
    }
    _currentLocale = Locale(localeCode);
    //Intl.defaultLocale = Intl.defaultLocale = localeCode;
    notifyListeners();
  }

  void changeLanguage(Locale type) async {
    if (_currentLocale == type) {
      return;
    }
    if (type == const Locale(arabicCode)) {
      _currentLocale = const Locale(arabicCode);
    } else {
      _currentLocale = const Locale(englishCode);
    }
    notifyListeners();
  }

  String get languageCode => _currentLocale.languageCode;

  void changeToArLanguage() {
    newLocale = Language.arabicCode;
    changeLanguage(Locale(Language.arabicCode));
    languageLocalRepository.saveLanguageCode(Language.arabicCode);
    notifyListeners();
  }

  void changeToEnLanguage() {
    newLocale = Language.englishCode;
    changeLanguage(Locale(Language.englishCode));
    languageLocalRepository.saveLanguageCode(Language.englishCode);
    notifyListeners();
  }
}
