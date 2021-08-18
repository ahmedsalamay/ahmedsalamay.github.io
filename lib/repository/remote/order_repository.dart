import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/city.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/facebook_album.dart';
import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/models/home_page_configuration.dart';
import 'package:fimto_frame/models/payments_methods.dart';
import 'package:fimto_frame/models/social_reviews.dart';
import 'package:fimto_frame/services/request_provider.dart';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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
}
