import 'package:async/async.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/token.dart';
import 'package:fimto_frame/repository/local/token_local_repository.dart';
import 'package:fimto_frame/repository/remote/token_repository.dart';

class TokenService {
  TokenService(this._tokenRepository, this._tokenLocalRepository);

  final TokenRepository _tokenRepository;
  final TokenLocalRepository _tokenLocalRepository;
  Token? _token;

  Future<Result<Token>> loginAsync(String phoneNumber, String password) async {
    var result = await _tokenRepository.loginAsync(phoneNumber, password);
    if (result.isError) {
      if (result.asError!.error == '') {
        return Result.error(S.current.loginError);
      }
      return Result.error(S.current.somethingWentWrong);
    }
    await _tokenLocalRepository.saveToken(result.asValue!.value);

    return Result.value(result.asValue!.value);
  }

  Future<Result<Token>> registerAsync(
      String phoneNumber, String email, String password) async {
    var result =
        await _tokenRepository.registerAsync(email, phoneNumber, password);
    if (result.isError) {
      return Result.error(result.asError!.error);
    }
    await _tokenLocalRepository.saveToken(result.asValue!.value);

    return Result.value(result.asValue!.value);
  }

  Future<String?> getAccessToken() async {
    _token = await _tokenLocalRepository.loadToken();
    return _token!.accessToken;
  }

  Future<Token?> refreshToken() async {
    await getAccessToken();

    try {
      var response = await _tokenRepository.refreshToken(_token!);
      _token = response.asValue!.value;
      _tokenLocalRepository.saveToken(_token!);
    } catch (e) {
      _tokenLocalRepository.clearToken();
      rethrow;
    }
    return _token;
  }
}
