import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/repository/remote/facebook_repository.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ChooseFrameViewModel extends ChangeNotifier {
  final FacebookRepository facebookRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  final Order order;

  ChooseFrameViewModel(
      {required this.facebookRepository,
      required this.order,
        required this.messageService,
      required this.connectionService});

  String get packageSize => order.packageSize.toString();
  String get packagePrice => order.packagePrice.toString();
  String get extraFramesPrice =>
      ((_pickedFiles.length - order.packageSize!) * order.extraImagePrice!)
          .toString();
  bool get isExtraFrames => _pickedFiles.length > order.packageSize!;
  String get deliveryFees =>
      order.deliveryFee! > 0 ? order.deliveryFee.toString() : S.current.free;
  String get total => (order.packagePrice! +
          (_pickedFiles.length - order.packageSize!) * order.extraImagePrice!)
      .toString();

  bool get showCheckOutButton =>
      true; //_pickedFiles.length >= order.packageSize!;

  var logger = Logger();

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;

  final List<Uint8List> _pickedFiles = [];

  List<Uint8List> get pickedFiles => _pickedFiles;

  bool get isImagesPicked => _pickedFiles.isNotEmpty;

  bool isDeleteButtonVisible = false;

  void addFacebookPhoto(List<String> sources) async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: S.current.connectionErrorHeader,
          message: S.current.connectionErrorMsg);
      return;
    }
    Get.back();
    setLoadingState(true);

    for (var source in sources) {
      var response = await Dio()
          .get(source, options: Options(responseType: ResponseType.bytes));
      _pickedFiles.add(response.data);
      order.calculateTotal();
      notifyListeners();
    }
    setLoadingState(false);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void showDeleteButton() {
    isDeleteButtonVisible = true;
    notifyListeners();
  }

  void hideDeleteButton() {
    isDeleteButtonVisible = false;
    notifyListeners();
  }

  frames _selectedFrame = frames.classic;
  frames get selectedFrame => _selectedFrame;
  void selectFrameAction(frames frame) {
    _selectedFrame = frame;
    notifyListeners();
  }

  Future<void> uploadPhoto() async {
    if (true) {
      setLoadingState(true);
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.image,
          onFileLoading: (status) {
            print('FilePickerStatus: $status');
            if (status == FilePickerStatus.done) {
              setLoadingState(false);
              print('FilePickerStatus: $status');
            }
          });
      if (result != null) {
        setLoadingState(false);
        if (kIsWeb) {
          List<Uint8List> files = result.files.map((e) => e.bytes!).toList();
          _pickedFiles.addAll(files);
          order.calculateTotal();
          notifyListeners();
        } else {
          List<File> files = result.files.map((e) => File(e.path!)).toList();
          files
              .map((e) => e.readAsBytes().then((value) {
                    _pickedFiles.add(value);
                    notifyListeners();
                  }))
              .toList();
          order.calculateTotal();
          notifyListeners();
        }
      }
    }
  }

  Future<PhotoPaging?> facebookLogin() async {
    setLoadingState(true);
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['user_photos', 'email', 'public_profile'],
    ); // by default we request the email and the public profile

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      // final graphResponse = await Dio().get(
      //     'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${_accessToken!.token}');
      // var albums = await facebookRepository.fetchAlbums(
      //     accessToken: _accessToken!.token);

      var photos = await facebookRepository.fetchAllPhotos(
          accessToken: _accessToken!.token, userId: userData['id']);
      //  '112357808842711' /* albums.asValue!.value.data.first.id.toString()*/);
      logger.i(photos);
      setLoadingState(false);
      return photos.asFuture;
    } else {
      print(result.status);
      print(result.message);
    }
    setLoadingState(false);
  }

  void removePhoto(int index) {
    _pickedFiles.removeAt(index);
    notifyListeners();
    if (!kIsWeb) {
      Get.back();
    }
  }

  void checkoutAction() {
    order
      ..frame = _selectedFrame.toString().split('.')[1]
      ..imageNo = _pickedFiles.length
      ..images = _pickedFiles.map((e) => base64Encode(e).toString()).toList()
      ..wallName = 'Montaser'; //TODO remove
    Get.toNamed(addAddressRoute);
  }
}
