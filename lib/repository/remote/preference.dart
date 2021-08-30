import 'package:hive/hive.dart';

class Preferences {
  static const _preferencesBox = '_preferencesBox';
  static const _firstLaunchKey = '_firstLaunchKey';
  static const _isLogged = '_loggedKey';
  final Box<dynamic> _box;

  Preferences._(this._box);

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox<dynamic>(_preferencesBox);
    return Preferences._(box);
  }

  bool getIsFirstLaunch() => _getValue(_firstLaunchKey, defaultValue: true);

  Future<void> setIsFirstLaunch(bool value) =>
      _setValue(_firstLaunchKey, value);

  bool getIsLogged() => _getValue(_isLogged, defaultValue: false);

  Future<void> setIsLogged(bool value) => _setValue(_isLogged, value);

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);
}
