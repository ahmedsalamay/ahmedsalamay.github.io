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

  /// `DecorateMyWall`
  String get decorateMyWall {
    return Intl.message(
      'DecorateMyWall',
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
