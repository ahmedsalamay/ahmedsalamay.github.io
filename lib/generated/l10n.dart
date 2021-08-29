// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `It doesn't need a nails`
  String get noNails {
    return Intl.message(
      'It doesn\'t need a nails',
      name: 'noNails',
      desc: '',
      args: [],
    );
  }

  /// `Our frames stick to any walls`
  String get framesStickWall {
    return Intl.message(
      'Our frames stick to any walls',
      name: 'framesStickWall',
      desc: '',
      args: [],
    );
  }

  /// `Shape for your frames`
  String get shapeFrame {
    return Intl.message(
      'Shape for your frames',
      name: 'shapeFrame',
      desc: '',
      args: [],
    );
  }

  /// `We give you the most suitable shape for the frames on your wall`
  String get suitableShape {
    return Intl.message(
      'We give you the most suitable shape for the frames on your wall',
      name: 'suitableShape',
      desc: '',
      args: [],
    );
  }

  /// `Shipping is always free`
  String get shippingFree {
    return Intl.message(
      'Shipping is always free',
      name: 'shippingFree',
      desc: '',
      args: [],
    );
  }

  /// `Free Egyptwide shipping! At your doorstep in a week`
  String get egyptwideShipping {
    return Intl.message(
      'Free Egyptwide shipping! At your doorstep in a week',
      name: 'egyptwideShipping',
      desc: '',
      args: [],
    );
  }

  /// `Ship To`
  String get shipTo {
    return Intl.message(
      'Ship To',
      name: 'shipTo',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get nameHint {
    return Intl.message(
      'Your Name',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneHint {
    return Intl.message(
      'Phone Number',
      name: 'phoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressHint {
    return Intl.message(
      'Address',
      name: 'addressHint',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get buildingNumberHint {
    return Intl.message(
      'Building Number',
      name: 'buildingNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get floorHint {
    return Intl.message(
      'Floor',
      name: 'floorHint',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get mailHint {
    return Intl.message(
      'E-Mail',
      name: 'mailHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm The Address`
  String get confirmAddress {
    return Intl.message(
      'Confirm The Address',
      name: 'confirmAddress',
      desc: '',
      args: [],
    );
  }

  /// `Select To Who`
  String get selectToWho {
    return Intl.message(
      'Select To Who',
      name: 'selectToWho',
      desc: '',
      args: [],
    );
  }

  /// `Please select to who you are creating frames`
  String get selectCreateFrames {
    return Intl.message(
      'Please select to who you are creating frames',
      name: 'selectCreateFrames',
      desc: '',
      args: [],
    );
  }

  /// `Gift`
  String get gift {
    return Intl.message(
      'Gift',
      name: 'gift',
      desc: '',
      args: [],
    );
  }

  /// `For a dear person`
  String get forPerson {
    return Intl.message(
      'For a dear person',
      name: 'forPerson',
      desc: '',
      args: [],
    );
  }

  /// `Don't require additional expenses`
  String get noAdditionalExpenses {
    return Intl.message(
      'Don\'t require additional expenses',
      name: 'noAdditionalExpenses',
      desc: '',
      args: [],
    );
  }

  /// `For Me`
  String get forMe {
    return Intl.message(
      'For Me',
      name: 'forMe',
      desc: '',
      args: [],
    );
  }

  /// `Decorate My Wall`
  String get decorateMyWall {
    return Intl.message(
      'Decorate My Wall',
      name: 'decorateMyWall',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueBTN {
    return Intl.message(
      'Continue',
      name: 'continueBTN',
      desc: '',
      args: [],
    );
  }

  /// `Choose your frame`
  String get chooseYourFrame {
    return Intl.message(
      'Choose your frame',
      name: 'chooseYourFrame',
      desc: '',
      args: [],
    );
  }

  /// `Choose your suitable designs on your wall`
  String get chooseSuitableDesign {
    return Intl.message(
      'Choose your suitable designs on your wall',
      name: 'chooseSuitableDesign',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get addAddress {
    return Intl.message(
      'Add Address',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Method`
  String get addPaymentMethod {
    return Intl.message(
      'Add Payment Method',
      name: 'addPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Choose Payment Method`
  String get choosePaymentMethod {
    return Intl.message(
      'Choose Payment Method',
      name: 'choosePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please transfer the total amount to`
  String get pleaseTransferAmountTo {
    return Intl.message(
      'Please transfer the total amount to',
      name: 'pleaseTransferAmountTo',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the payment Method`
  String get confirmPaymentMethod {
    return Intl.message(
      'Confirm the payment Method',
      name: 'confirmPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Your payment will be confirmed automatically if the sender number register at your order if not, please contact us to confirm the payment`
  String get paymentConfirmAutomatically {
    return Intl.message(
      'Your payment will be confirmed automatically if the sender number register at your order if not, please contact us to confirm the payment',
      name: 'paymentConfirmAutomatically',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Order`
  String get confirmYourOrder {
    return Intl.message(
      'Confirm Your Order',
      name: 'confirmYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Time`
  String get deliveryTime {
    return Intl.message(
      'Delivery Time',
      name: 'deliveryTime',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order`
  String get confirmOrder {
    return Intl.message(
      'Confirm Order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Leave a message`
  String get leaveMessage {
    return Intl.message(
      'Leave a message',
      name: 'leaveMessage',
      desc: '',
      args: [],
    );
  }

  /// `Leave a message to your dear person`
  String get messageToYourDear {
    return Intl.message(
      'Leave a message to your dear person',
      name: 'messageToYourDear',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congratulations {
    return Intl.message(
      'Congratulations',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `The Order has been confirmed`
  String get orderConfirmed {
    return Intl.message(
      'The Order has been confirmed',
      name: 'orderConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `A successful purchase for your frames`
  String get successfulPurchase {
    return Intl.message(
      'A successful purchase for your frames',
      name: 'successfulPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get orderNumber {
    return Intl.message(
      'Order Number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `You can track your order from here`
  String get canTrackYourOrder {
    return Intl.message(
      'You can track your order from here',
      name: 'canTrackYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Track Your Order`
  String get trackYourOrder {
    return Intl.message(
      'Track Your Order',
      name: 'trackYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order is confirmed`
  String get orderIsConfirmed {
    return Intl.message(
      'Order is confirmed',
      name: 'orderIsConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Delivered for shipment`
  String get deliveredForShipment {
    return Intl.message(
      'Delivered for shipment',
      name: 'deliveredForShipment',
      desc: '',
      args: [],
    );
  }

  /// `delivered`
  String get delivered {
    return Intl.message(
      'delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Talk to us`
  String get talkToUs {
    return Intl.message(
      'Talk to us',
      name: 'talkToUs',
      desc: '',
      args: [],
    );
  }

  /// `Add promo code`
  String get addPromoCode {
    return Intl.message(
      'Add promo code',
      name: 'addPromoCode',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Use policy`
  String get usePolicy {
    return Intl.message(
      'Use policy',
      name: 'usePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Your orders`
  String get yourOrders {
    return Intl.message(
      'Your orders',
      name: 'yourOrders',
      desc: '',
      args: [],
    );
  }

  /// `Fimtosoft`
  String get fimtoSoft {
    return Intl.message(
      'Fimtosoft',
      name: 'fimtoSoft',
      desc: '',
      args: [],
    );
  }

  /// `Fimto Art`
  String get fimtoArt {
    return Intl.message(
      'Fimto Art',
      name: 'fimtoArt',
      desc: '',
      args: [],
    );
  }

  /// `Follow us`
  String get followUs {
    return Intl.message(
      'Follow us',
      name: 'followUs',
      desc: '',
      args: [],
    );
  }

  /// `Pick some photos to get started`
  String get pickUpSomePhotos {
    return Intl.message(
      'Pick some photos to get started',
      name: 'pickUpSomePhotos',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photos`
  String get uploadPhotos {
    return Intl.message(
      'Upload Photos',
      name: 'uploadPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Import From Facebook`
  String get importFromFacebook {
    return Intl.message(
      'Import From Facebook',
      name: 'importFromFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Import From Instagram`
  String get importFromInstagram {
    return Intl.message(
      'Import From Instagram',
      name: 'importFromInstagram',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Let's Go`
  String get letsGo {
    return Intl.message(
      'Let\'s Go',
      name: 'letsGo',
      desc: '',
      args: [],
    );
  }

  /// `Frame your moments`
  String get frameYourMoment {
    return Intl.message(
      'Frame your moments',
      name: 'frameYourMoment',
      desc: '',
      args: [],
    );
  }

  /// `Change the location without leaving any trace`
  String get changLocation {
    return Intl.message(
      'Change the location without leaving any trace',
      name: 'changLocation',
      desc: '',
      args: [],
    );
  }

  /// `Perfect frame size 21X21`
  String get perfectSize {
    return Intl.message(
      'Perfect frame size 21X21',
      name: 'perfectSize',
      desc: '',
      args: [],
    );
  }

  /// `You can change the photo inside the frame any time`
  String get youCanChangeThePhoto {
    return Intl.message(
      'You can change the photo inside the frame any time',
      name: 'youCanChangeThePhoto',
      desc: '',
      args: [],
    );
  }

  /// `We will add an Aesthetic touch to your photos`
  String get addAestheticTouch {
    return Intl.message(
      'We will add an Aesthetic touch to your photos',
      name: 'addAestheticTouch',
      desc: '',
      args: [],
    );
  }

  /// `We guarantee our frame!`
  String get guaranteeOurFrames {
    return Intl.message(
      'We guarantee our frame!',
      name: 'guaranteeOurFrames',
      desc: '',
      args: [],
    );
  }

  /// `You can retrieve it if it isn't in the required form`
  String get youCanRetrieve {
    return Intl.message(
      'You can retrieve it if it isn\'t in the required form',
      name: 'youCanRetrieve',
      desc: '',
      args: [],
    );
  }

  /// `Get three Frames with 270 LE only`
  String get getThreeFrames {
    return Intl.message(
      'Get three Frames with 270 LE only',
      name: 'getThreeFrames',
      desc: '',
      args: [],
    );
  }

  /// `You can add extra frame with only 74LE`
  String get youCanExtraFrame {
    return Intl.message(
      'You can add extra frame with only 74LE',
      name: 'youCanExtraFrame',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `password error`
  String get passwordError {
    return Intl.message(
      'password error',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Not Valid Phone number`
  String get phoneNumberError {
    return Intl.message(
      'Not Valid Phone number',
      name: 'phoneNumberError',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connectionErrorHeader {
    return Intl.message(
      'Connection Error',
      name: 'connectionErrorHeader',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection, Please check your wifi or cellular data`
  String get connectionErrorMsg {
    return Intl.message(
      'No internet connection, Please check your wifi or cellular data',
      name: 'connectionErrorMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait for data to be loaded`
  String get loadingData {
    return Intl.message(
      'Please Wait for data to be loaded',
      name: 'loadingData',
      desc: '',
      args: [],
    );
  }

  /// `Sorry`
  String get sorry {
    return Intl.message(
      'Sorry',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have Account?`
  String get donnotHaveAccount {
    return Intl.message(
      'Don\'t Have Account?',
      name: 'donnotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Already have account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Frames`
  String get frames {
    return Intl.message(
      'Frames',
      name: 'frames',
      desc: '',
      args: [],
    );
  }

  /// `Extra Frame`
  String get extraFrame {
    return Intl.message(
      'Extra Frame',
      name: 'extraFrame',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `LE`
  String get le {
    return Intl.message(
      'LE',
      name: 'le',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `PLease choose delivery date first`
  String get pleaseChooseDate {
    return Intl.message(
      'PLease choose delivery date first',
      name: 'pleaseChooseDate',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Name:`
  String get name {
    return Intl.message(
      'Name:',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'total:' key

  /// `Phone:`
  String get phone {
    return Intl.message(
      'Phone:',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Status:`
  String get status {
    return Intl.message(
      'Status:',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Paid:`
  String get paid {
    return Intl.message(
      'Paid:',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
