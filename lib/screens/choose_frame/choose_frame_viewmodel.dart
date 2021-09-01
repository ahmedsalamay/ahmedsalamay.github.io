import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:fimto_frame/generated/l10n.dart';
import 'package:fimto_frame/models/constants.dart';
import 'package:fimto_frame/models/facebook_photo.dart';
import 'package:fimto_frame/models/instagram_page.dart';
import 'package:fimto_frame/models/order.dart';
import 'package:fimto_frame/models/walls.dart';
import 'package:fimto_frame/repository/remote/facebook_repository.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/repository/remote/preference.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/services/connection_service.dart';
import 'package:fimto_frame/services/message_service.dart';
import 'package:fimto_frame/services/token_services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
//import 'dart:html' as html;
import 'choose_frame_mobile.dart';

class ChooseFrameViewModel extends ChangeNotifier {
  final FacebookRepository facebookRepository;
  final ConnectionService connectionService;
  final MessageService messageService;
  final OrderRepository orderRepository;
  final TokenService? tokenService;
  final Order order;

  ChooseFrameViewModel(
      {required this.facebookRepository,
      required this.order,
      required this.messageService,
      required this.orderRepository,
      this.tokenService,
      required this.connectionService}) {
    loadWalls();
  }

  List<Walls>? _walls;
  List<Walls>? get walls => _walls;
  Walls get wall =>
      _walls!.firstWhere((wall) => wall.noImage == _pickedFiles.length,
          orElse: () => _walls!.last);

  String get packageSize => order.packageSize!.toInt().toString();
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

  bool get showCheckOutButton => _pickedFiles.length >= order.packageSize!;

  var logger = Logger();

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;

  final List<Uint8List> _pickedFiles = [];

  List<Uint8List> get pickedFiles => _pickedFiles;

  bool get isImagesPicked => _pickedFiles.isNotEmpty;
  bool get isWallVisible => _walls != null && _pickedFiles.isNotEmpty;

  bool isDeleteButtonVisible = false;

  String? _phoneNumber;
  String? _password;

  void onPhoneNumberChange(String userName) {
    _phoneNumber = userName;
    notifyListeners();
  }

  void onPasswordChange(String password) {
    _password = password;
    notifyListeners();
  }

  String? validatePhoneNumber(String? phone) =>
      !_isValidPhoneNumber(phone) ? S.current.phoneNumberError : null;

  String? validatePassword(String? password) =>
      password!.isEmpty ? S.current.passwordError : null;

  void logInAction(GlobalKey<FormState> formKey) {
    final form = formKey.currentState!;
    if (form.validate()) {
      _logIn();
    }
  }

  void _logIn() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: '', message: S.current.connectionErrorMsg);
      return;
    }

    if (_isLoading) {
      messageService.showErrorSnackBar(
          title: '', message: S.current.loadingData);
      return;
    }

    setLoadingLogin(true);

    var response = await tokenService!.loginAsync(_phoneNumber!, _password!);
    if (response.isError) {
      messageService.showErrorSnackBar(
          title: '', message: response.asError!.error.toString());
      setLoadingLogin(false);
      return;
    }
    setLoadingLogin(false);
    final preferences = await Preferences.getInstance();
    preferences.setIsLogged(true);
    Get.back(result: true);
  }

  bool _isValidPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return value.length == minNumber;
  }

  void addFacebookPhoto(List<String> sources) async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: S.current.connectionErrorHeader,
          message: S.current.connectionErrorMsg);
      return;
    }
    Get.back();
    setLoadingLogin(true);

    for (var source in sources) {
      var response = await Dio()
          .get(source, options: Options(responseType: ResponseType.bytes));
      _pickedFiles.add(response.data);
      order.imageNo = _pickedFiles.length;

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

  bool _isLoadingLogin = false;
  bool get isLoadingLogin => _isLoadingLogin;
  void setLoadingLogin(bool value) {
    _isLoadingLogin = value;
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
          order.imageNo = _pickedFiles.length;

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
          order.imageNo = _pickedFiles.length;
          order.calculateTotal();
          notifyListeners();
        }
      }
    }
  }

  Future instgramLogin() async {
    List<Media>? medias;

    if (kIsWeb) {
      /*  html.window.open(
          "https://api.instagram.com/oauth/authorize?&scope=user_profile,user_media&response_type=code&client_id=400912798059223&redirect_uri=https://localhost:65308/$instaPickerRoute",
          '_self');*/
    } else {
      Get.dialog(const WebViewDialogDemo());

      final flutterWebviewPlugin = FlutterWebviewPlugin();
      flutterWebviewPlugin.launch(InstagramConst.authorizeCodeApiUrl);
      flutterWebviewPlugin.onUrlChanged.listen((String url) async {
        if (url.startsWith('https://hadaf.vemtto.pickinstagram.com')) {
          Get.back();

          var uri = Uri.parse(url);
          final code = uri.queryParameters["code"];

          flutterWebviewPlugin.close();

          List<Media> result =
              await Get.toNamed(instaPickerRoute, arguments: code);

          setLoadingState(true);
          
          var sources = result.map((e) => e.mediaUrl).toList();
          for (var source in sources) {
            var response = await Dio().get(source,
                options: Options(responseType: ResponseType.bytes));
            _pickedFiles.add(response.data);
          }

          order.imageNo = _pickedFiles.length;
          order.calculateTotal();
          setLoadingState(false);
        }
      });
    }
  }

  Future<PhotoPaging?> facebookLogin() async {
    setLoadingState(true);
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'user_photos',
        'email',
        'public_profile',
      ],
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

  Future<void> loadWalls() async {
    var isConnected = await connectionService.checkConnection();
    if (!isConnected) {
      messageService.showErrorSnackBar(
          title: S.current.connectionErrorHeader,
          message: S.current.connectionErrorMsg);
      return;
    }
    setLoadingState(true);
    var response = await orderRepository.getWalls();
    if (response.isError) {
      setLoadingState(false);

      messageService.showErrorSnackBar(
          title: '', message: S.current.connectionErrorMsg);
      return;
    }
    _walls = response.asValue!.value;
    setLoadingState(false);
  }

  Future<bool> isUserLogged() async {
    final preferences = await Preferences.getInstance();
    return preferences.getIsLogged();
  }

  Future<void> navigateToLogin() async {
    var isLogged = await Get.toNamed(loginRoute, arguments: true);
    if (isLogged ?? false) {}
  }

  void checkoutAction() async {
    order
      ..frame = _selectedFrame.toString().split('.')[1]
      ..imageNo = _pickedFiles.length
      ..images = _pickedFiles.map((e) => base64Encode(e).toString()).toList()
      ..wallName = _walls!
          .firstWhere((wall) => wall.noImage == _pickedFiles.length,
              orElse: () => _walls!.first)
          .wallName;
    Get.toNamed(addAddressRoute);
  }
}
