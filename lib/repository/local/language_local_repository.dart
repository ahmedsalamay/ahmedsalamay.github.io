import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fimto_frame/models/language.dart';

const String configurationBoxName = 'languageBox';

class LanguageLocalRepository {
  Future saveLanguageCode(String langCode) async {
    var languageBox = await Hive.openBox(configurationBoxName);
    await languageBox.put('langCode', langCode);
  }

  Future<String> getSavedLanguageCode() async {
    var languageBox = await Hive.openBox(configurationBoxName);
    return (languageBox.get('langCode'));
  }

  Future<Language> getSavedLaunage() async {
    await Hive.initFlutter();
    var languageBox = await Hive.openBox(configurationBoxName);
    var languageCode = (languageBox.get('langCode'));

    var language = Language();
    if (languageCode != null && languageCode.isNotEmpty) {
      language.newLocale = languageCode;
      Intl.defaultLocale = Intl.defaultLocale = languageCode;
    }
    return language;
  }
}
