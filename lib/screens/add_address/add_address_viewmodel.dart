import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/city.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  final Order order;
  AddAddressViewModel(
      {required this.connectionService,
      required this.messageService,
      required this.orderRepository,
      required this.order});

  Future<void> initAsync() async {
    var citiesResponse = await orderRepository.getCities();
    if (citiesResponse.isError) {}
    _cities = citiesResponse.asValue!.value;
    setLoadingState(false);
  }

  String? _userName;
  String? _phoneNumber;
  String? _address;
  String? _buildNo;
  String? _floor;
  String? _email;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<City>? _cities;
  List<City>? get cities => _cities;
  City? _selectedCity;
  City? get selectedCity => _selectedCity;

  void selectCity(City value) {
    _selectedCity = value;
    _regions = _selectedCity!.regions;
    _selectedRegion = null;
    notifyListeners();
  }

  List<Region>? _regions;
  List<Region>? get regions => _regions;
  Region? _selectedRegion;
  Region? get selectedRegion => _selectedRegion;

  void selectRegion(Region value) {
    _selectedRegion = value;
    notifyListeners();
  }

  void onUserNameChange(String value) {
    _userName = value;
  }

  void onPhoneNumberChange(String value) {
    _phoneNumber = value;
  }

  void onAddressChange(String value) {
    _address = value;
  }

  void onBuildNoChange(String value) {
    _buildNo = value;
  }

  void onFloorChange(String value) {
    _floor = value;
  }

  void onEmailChange(String value) {
    _email = value;
  }

  String? validateUserName(String? value) =>
      value!.isEmpty ? S.current.passwordError : null;

  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void confirmAddressAction() {
    order
      ..name = _userName
      ..phone = _phoneNumber
      ..city = _selectedCity!.name
      ..region = _selectedRegion!.name
      ..address = _address
      ..buildingNo = _buildNo
      ..floor = _floor
      ..email = _email;
    Get.toNamed(addPaymentMethodRoute);
  }
}
