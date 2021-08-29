import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/city.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/order_status.dart';
import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/models/walls.dart';
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
    } catch (err, _) {
      return Result.error(err);
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

  Future<Result<List<Walls>>> getWalls() async {
    try {
      var response = await requestProvider.getAsync('api/Wall');
      if (response.statusCode == 200) {
        var walls =
            List<Walls>.from(response.data.map((e) => Walls.fromJson(e)));
        return Result.value(walls);
      } else {
        return Result.error(response.data.toString());
      }
    } on DioError {
      return Result.error(DioError);
    }
  }
}
