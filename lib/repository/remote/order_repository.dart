import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/city.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/order_status.dart';
import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/services/request_provider.dart';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:dio/dio.dart';

class OrderRepository {
  final RequestProvider requestProvider;
  OrderRepository(this.requestProvider);

  Future<Result<List<City>>> getCities() async {
    try {
      var response = await requestProvider.getAsync('api/City');
      if (response.statusCode == 200) {
        var cities =
            List<City>.from(response.data.map((e) => City.fromJson(e)));
        return Result.value(cities);
      } else {
        return Result.error(response.data['ErrorString'].toString());
      }
    } on DioError {
      return Result.error(DioError);
    }
  }

  Future<Result<List<PaymentsMethods>>> getPaymentMethods() async {
    try {
      var response = await requestProvider.getAsync('api/Payment');
      if (response.statusCode == 200) {
        var payments = List<PaymentsMethods>.from(
            response.data.map((e) => PaymentsMethods.fromJson(e)));
        return Result.value(payments);
      } else {
        return Result.error(response.data['ErrorString'].toString());
      }
    } on DioError {
      return Result.error(DioError);
    }
  }

  Future<Result<List<OrderStatus>>> getOrdersStatus() async {
    try {
      var response = await requestProvider.getAsync('api/Order');
      if (response.statusCode == 200) {
        var payments = List<OrderStatus>.from(
            response.data.map((e) => OrderStatus.fromJson(e)));
        return Result.value(payments);
      } else {
        return Result.error(response.data.toString());
      }
    } on DioError {
      return Result.error(DioError);
    }
  }

  Future<Result<void>> submitOrder(Order order) async {
    try {
      var body = json.encode(order.toJson());
      var response =
          await requestProvider.postAsync(resource: 'api/Order', body: body);

      if (response.statusCode == 200) {
        return Result.value('');
      } else {
        return Result.error(S.current.connectionErrorHeader);
      }
    } on DioError {
      return Result.error(S.current.connectionErrorHeader);
    }
  }

  Future<Result<PromoCode>> checkPromoCode(String code) async {
    try {
      var response =
          await requestProvider.getAsync('api/PromoCode?promocode=$code');
      if (response.statusCode == 200) {
        var promoCode = PromoCode.fromJson(code, response.data);
        return Result.value(promoCode);
      } else {
        return Result.error(response.data.toString());
      }
    } on DioError {
      return Result.error(DioError);
    }
  }
}

const token =
    'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjIxQTc3MTg3NzNEQkNBRDlCMENGRUM0OEQ4M0UzOENGIiwidHlwIjoiYXQrand0In0.eyJuYmYiOjE2Mjk2NTA1NTcsImV4cCI6MTY0MDQ1MDU1NywiaXNzIjoiaHR0cHM6Ly9maW10b2ZyYW1lLmhhZGFmLndlYnNpdGUiLCJhdWQiOiJodHRwczovL2ZpbXRvZnJhbWUuaGFkYWYud2Vic2l0ZS9yZXNvdXJjZXMiLCJjbGllbnRfaWQiOiJtb2JpbGUiLCJzdWIiOiI2IiwiYXV0aF90aW1lIjoxNjI5NjUwNTU2LCJpZHAiOiJsb2NhbCIsImp0aSI6IjY4Q0ZENUFFMDJERTU4Q0MwOUI5MDI2NDgxMTY1QkM3IiwiaWF0IjoxNjI5NjUwNTU2LCJzY29wZSI6WyJmaW10b19hcGkiLCJvcGVuaWQiLCJwcm9maWxlIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.PYyuFJmbTSdjWya6BVbCHR3FNRUxENCNHL0oCKHGz3v9jpD1l2fzldGbyV-KYRFISQInAc7C7uD5aReHB2m9HMgadIYyEE4ZbPPx9jWgKKP77sxtlTU-TQ1eaMqbv1eCNLX3H4HzD5y1toq2-X4vG4E4AD_FD0WGXSqcvDX77MecwEFjs3yG3DLngVrxPwj5ZkQPHbvOySzmxkPq2t-2WL6rOvRqBq16wrkjfOG0E82WWxwGNBH6JAaIzTkqeXUuyzTTA91olUpzPzNtxDOdKKxImTJDKSySnHk1bBub7HA9EtNgC9uQR3udOyOEoXJel2Qb1Eo-Pvh5aNGZ2Sx74Q';
