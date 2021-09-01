import 'package:fimto_frame/models/token.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String tokenBoxName = 'tokenBox';

class TokenLocalRepository {
  late Box<Token> tokenBox;

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TokenAdapter());
    await Hive.openBox<Token>('token');
    tokenBox = Hive.box('token');
  }

  Future<void> saveToken(Token token) async {
    await Hive.initFlutter();
    tokenBox = Hive.box('token');
    tokenBox.put('token', token);
  }

  Future<Token> loadToken() async {
    await Hive.initFlutter();
    tokenBox = Hive.box('token');
    var token = tokenBox.values.toList().first;
    return token;
  }

  Future<bool> isTokenSaved() async {
    await Hive.initFlutter();
    tokenBox = Hive.box('token');
    return tokenBox.values.isNotEmpty;
  }

  void clearToken() {
    tokenBox.clear();
  }
}
