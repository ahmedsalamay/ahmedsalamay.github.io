import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:dio_logger/dio_logger.dart';

class RequestProvider {
  final TokenService tokenService;
  final Language language;

  Future<Null>? refreshTokenInProgress;

  final Dio _client = Dio();
  RequestProvider({
    required this.tokenService,
    required this.language,
  }) {
    _client.interceptors.add(dioLoggerInterceptor);

    _client.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, handler) async {
        if (error.response!.statusCode == HttpStatus.unauthorized) {
          if (refreshTokenInProgress != null) {
            await refreshTokenInProgress; // wait for future complete
          }

          // lock
          var completer = Completer<Null>();
          refreshTokenInProgress = completer.future;

          _client.interceptors.requestLock.lock();
          _client.interceptors.responseLock.lock();

          var options = error.response!.requestOptions;

          try {
            var token = await tokenService.getAccessToken();
            token = 'Bearer ' + token!;
            if (token != options.headers['Authorization']) {
              _client.interceptors.requestLock.unlock();
              _client.interceptors.responseLock.unlock();

              // unlock
              completer.complete();
              refreshTokenInProgress = null;
              options.headers['Authorization'] = token;

              _client.fetch(options).then(
                (r) => handler.resolve(r),
                onError: (e) {
                  handler.reject(e);
                },
              );
              return;
            } else {
              return tokenService.refreshToken().then((newToken) {
                //update csrfToken
                options.headers['Authorization'] =
                    'Bearer ${newToken!.accessToken}';
              }).whenComplete(() {
                _client.interceptors.requestLock.unlock();
                _client.interceptors.responseLock.unlock();

                // unlock
                completer.complete();
                refreshTokenInProgress = null;
              }).then((e) {
                //repeat
                _client.fetch(options).then(
                  (r) => handler.resolve(r),
                  onError: (e) {
                    handler.reject(e);
                  },
                );
                return;
              });
            }
          } catch (exception, stack) {
            // FirebaseCrashlytics.instance.recordError(exception, stack);

            rethrow;
          }
        } else {
          // FirebaseCrashlytics.instance.log(error.message);
          return handler.next(error);
        }
      },
      onRequest: (RequestOptions options, handler) async {
        _client.interceptors.requestLock.lock();

        var token = await tokenService.getAccessToken();

        options.headers["Authorization"] = "Bearer $token";
        _client.interceptors.requestLock.unlock();
        return handler.next(options);
      },
    ));

    _client.options.responseType = ResponseType.json;
    _client.options.baseUrl = '';
    _client.options.connectTimeout = 10 * 1000;
    _client.options.receiveTimeout = 10 * 1000;
    _client.options.headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      //'Access-Control-Allow-Origin': '*',
      'Accept-Language':
          language.languageCode == Language.arabicCode ? 'ar-EG' : 'en-US',
    };
  }

  Future<Response> getAsync(String resource) {
    return _client.get(
      baseUrl + resource,
    );
  }

  Future<Response> postAsync(
      {required String resource, dynamic body, String? token}) {
    return _client.post(
      baseUrl + resource,
      data: body,
    );
  }

  Future<Response> putAsync({required String resource, String? body}) {
    return _client.put(baseUrl + resource, data: body);
  }

  Future<Response> deleteAsync(String resource, {String? body}) {
    return _client.delete(baseUrl + resource);
  }

  Future<Response> patchAsync(String resource, {String? body}) {
    return _client.patch(baseUrl + resource, data: body);
  }

  Future<Response> getBytesAsync(String url) {
    return _client.get(
      baseUrl + url,
      options: Options(responseType: ResponseType.bytes),
    );
  }
}
