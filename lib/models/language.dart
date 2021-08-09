import 'package:fimto_frame/repository/local/language_local_repository.dart';
import 'package:flutter/material.dart';

class Language extends ChangeNotifier {
  final LanguageLocalRepository languageLocalRepository =
      LanguageLocalRepository();

  static const String arabicCode = 'ar';
  static const String englishCode = 'en';

  Locale _currentLocale = Locale(Language.englishCode);
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
    if (type == Locale(arabicCode)) {
      _currentLocale = Locale(arabicCode);
    } else {
      _currentLocale = Locale(englishCode);
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
