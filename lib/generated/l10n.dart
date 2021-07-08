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

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Code`
  String get enterYourCode {
    return Intl.message(
      'Enter Your Code',
      name: 'enterYourCode',
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

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, please try again later`
  String get errorHappenedTryLater {
    return Intl.message(
      'An error occurred, please try again later',
      name: 'errorHappenedTryLater',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username`
  String get userNameError {
    return Intl.message(
      'Please enter your username',
      name: 'userNameError',
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

  /// `Please enter your password`
  String get passwordError {
    return Intl.message(
      'Please enter your password',
      name: 'passwordError',
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

  /// `Physical Inventory`
  String get physicalInventory {
    return Intl.message(
      'Physical Inventory',
      name: 'physicalInventory',
      desc: '',
      args: [],
    );
  }

  /// `Item Inquiry`
  String get itemInquiry {
    return Intl.message(
      'Item Inquiry',
      name: 'itemInquiry',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Goods`
  String get receiptGoods {
    return Intl.message(
      'Receipt Goods',
      name: 'receiptGoods',
      desc: '',
      args: [],
    );
  }

  /// `Good Issue`
  String get goodIssue {
    return Intl.message(
      'Good Issue',
      name: 'goodIssue',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Goods`
  String get transferGoods {
    return Intl.message(
      'Transfer Goods',
      name: 'transferGoods',
      desc: '',
      args: [],
    );
  }

  /// `Update Data`
  String get updateData {
    return Intl.message(
      'Update Data',
      name: 'updateData',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Change Company`
  String get changeCompany {
    return Intl.message(
      'Change Company',
      name: 'changeCompany',
      desc: '',
      args: [],
    );
  }

  /// `Material Inquiry`
  String get materialInquiry {
    return Intl.message(
      'Material Inquiry',
      name: 'materialInquiry',
      desc: '',
      args: [],
    );
  }

  /// `Inventory Management`
  String get inventoryManagement {
    return Intl.message(
      'Inventory Management',
      name: 'inventoryManagement',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Material Name`
  String get materialName {
    return Intl.message(
      'Material Name',
      name: 'materialName',
      desc: '',
      args: [],
    );
  }

  /// `From Date`
  String get fromDate {
    return Intl.message(
      'From Date',
      name: 'fromDate',
      desc: '',
      args: [],
    );
  }

  /// `To Date`
  String get toDate {
    return Intl.message(
      'To Date',
      name: 'toDate',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Inventory Location`
  String get inventoryLocation {
    return Intl.message(
      'Inventory Location',
      name: 'inventoryLocation',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `Invalid period`
  String get invalidPeriodError {
    return Intl.message(
      'Invalid period',
      name: 'invalidPeriodError',
      desc: '',
      args: [],
    );
  }

  /// `This material not exists in the physical inventory`
  String get materialNotExistsOnPhysicalInventoryError {
    return Intl.message(
      'This material not exists in the physical inventory',
      name: 'materialNotExistsOnPhysicalInventoryError',
      desc: '',
      args: [],
    );
  }

  /// `Physical inventory completing date can't be before start date`
  String get inventoryEndingDateEarlierStartDateError {
    return Intl.message(
      'Physical inventory completing date can\'t be before start date',
      name: 'inventoryEndingDateEarlierStartDateError',
      desc: '',
      args: [],
    );
  }

  /// `Physical inventory completing date can't be before the last count date`
  String get inventoryEndingDateEarlierCountDateError {
    return Intl.message(
      'Physical inventory completing date can\'t be before the last count date',
      name: 'inventoryEndingDateEarlierCountDateError',
      desc: '',
      args: [],
    );
  }

  /// `Counting date can't be before start date`
  String get countingDateEarlierStartingDateError {
    return Intl.message(
      'Counting date can\'t be before start date',
      name: 'countingDateEarlierStartingDateError',
      desc: '',
      args: [],
    );
  }

  /// `The physical inventory is closed`
  String get closedInventoryErrorError {
    return Intl.message(
      'The physical inventory is closed',
      name: 'closedInventoryErrorError',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Please enter physical inventory complete date`
  String get enterPhysicalCompletingDate {
    return Intl.message(
      'Please enter physical inventory complete date',
      name: 'enterPhysicalCompletingDate',
      desc: '',
      args: [],
    );
  }

  /// `Search Physical Inventory`
  String get searchPhysicalInventory {
    return Intl.message(
      'Search Physical Inventory',
      name: 'searchPhysicalInventory',
      desc: '',
      args: [],
    );
  }

  /// `Inventory Start Date`
  String get inventoryStartDate {
    return Intl.message(
      'Inventory Start Date',
      name: 'inventoryStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Material Code`
  String get materialCode {
    return Intl.message(
      'Material Code',
      name: 'materialCode',
      desc: '',
      args: [],
    );
  }

  /// `Storage Bin`
  String get storageBin {
    return Intl.message(
      'Storage Bin',
      name: 'storageBin',
      desc: '',
      args: [],
    );
  }

  /// `Gross Weight`
  String get grossWeight {
    return Intl.message(
      'Gross Weight',
      name: 'grossWeight',
      desc: '',
      args: [],
    );
  }

  /// `Net Weight`
  String get netWeight {
    return Intl.message(
      'Net Weight',
      name: 'netWeight',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Inventory`
  String get inventory {
    return Intl.message(
      'Inventory',
      name: 'inventory',
      desc: '',
      args: [],
    );
  }

  /// `Qty`
  String get quantity {
    return Intl.message(
      'Qty',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message(
      'Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `This material not exists`
  String get materialIsNotExistsError {
    return Intl.message(
      'This material not exists',
      name: 'materialIsNotExistsError',
      desc: '',
      args: [],
    );
  }

  /// `No units for this item`
  String get noUnitsForThisItemError {
    return Intl.message(
      'No units for this item',
      name: 'noUnitsForThisItemError',
      desc: '',
      args: [],
    );
  }

  /// `Counting Date`
  String get countingDate {
    return Intl.message(
      'Counting Date',
      name: 'countingDate',
      desc: '',
      args: [],
    );
  }

  /// `Load Data`
  String get loadData {
    return Intl.message(
      'Load Data',
      name: 'loadData',
      desc: '',
      args: [],
    );
  }

  /// `Please press done or cancel before add another material`
  String get pressDoneOrCancelFirstError {
    return Intl.message(
      'Please press done or cancel before add another material',
      name: 'pressDoneOrCancelFirstError',
      desc: '',
      args: [],
    );
  }

  /// `the current data will be cleared, continue?`
  String get savedDataDeleteWarning {
    return Intl.message(
      'the current data will be cleared, continue?',
      name: 'savedDataDeleteWarning',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Inventory status`
  String get physicalInventoryStatus {
    return Intl.message(
      'Inventory status',
      name: 'physicalInventoryStatus',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Your password`
  String get yourPassword {
    return Intl.message(
      'Your password',
      name: 'yourPassword',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading data, please retry to load it again`
  String get errorOccurredReloadData {
    return Intl.message(
      'An error occurred while loading data, please retry to load it again',
      name: 'errorOccurredReloadData',
      desc: '',
      args: [],
    );
  }

  /// `Material inventory details`
  String get materialInventoryDetail {
    return Intl.message(
      'Material inventory details',
      name: 'materialInventoryDetail',
      desc: '',
      args: [],
    );
  }

  /// `the current data will be cleared, continue?`
  String get dataClearWarning {
    return Intl.message(
      'the current data will be cleared, continue?',
      name: 'dataClearWarning',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Close Physical Inventory`
  String get closePhysicalInventory {
    return Intl.message(
      'Close Physical Inventory',
      name: 'closePhysicalInventory',
      desc: '',
      args: [],
    );
  }

  /// `This physical inventory not started yet.`
  String get physicalInventoryNotStartedError {
    return Intl.message(
      'This physical inventory not started yet.',
      name: 'physicalInventoryNotStartedError',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get rUSureWarning {
    return Intl.message(
      'Are you sure?',
      name: 'rUSureWarning',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the end date of physical inventory`
  String get enterEndDate {
    return Intl.message(
      'Please enter the end date of physical inventory',
      name: 'enterEndDate',
      desc: '',
      args: [],
    );
  }

  /// `This material already exist with this unit`
  String get materialAlreadyExistsError {
    return Intl.message(
      'This material already exist with this unit',
      name: 'materialAlreadyExistsError',
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
