import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.light,
  primaryColor: FimtoColors.primaryColor,
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: FimtoColors.lightPrimaryColor,
  primaryColorDark: FimtoColors.darkPrimaryColor,
  accentColor: FimtoColors.accentColor,
  accentColorBrightness: Brightness.dark,
  canvasColor: Color(0xfffafafa),
  scaffoldBackgroundColor: FimtoColors.surfaceColor,
  bottomAppBarColor: Color(0xffffffff),
  cardColor: FimtoColors.surfaceColor,
  dividerColor: FimtoColors.dividerColor,
  highlightColor: Color(0x66bcbcbc),
  splashColor: Color(0xFFe84524),
  selectedRowColor: Color(0xfff5f5f5),
  unselectedWidgetColor: Color(0x8a000000),
  disabledColor: Color(0x61000000),
  buttonColor: Color(0xffe84524),
  toggleableActiveColor: Color(0xff1e88e5),
  secondaryHeaderColor: Color(0xffe3f2fd),
  backgroundColor: Color(0xff90caf9),
  dialogBackgroundColor: Color(0xffffffff),
  indicatorColor: FimtoColors.secondaryColor,
  hintColor: FimtoColors.hintColor,
  errorColor: FimtoColors.errorColor,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    alignedDropdown: false,
    buttonColor: Color(0xffe0e0e0),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x29000000),
    splashColor: Color(0x1f000000),
    focusColor: Color(0x1f000000),
    hoverColor: Color(0x0a000000),
    colorScheme: ColorScheme(
      primary: FimtoColors.primaryColor,
      primaryVariant: FimtoColors.darkPrimaryColor,
      secondary: FimtoColors.secondaryColor,
      secondaryVariant: Color(0xff1976d2),
      surface: FimtoColors.surfaceColor,
      background: Color(0xff90caf9),
      error: FimtoColors.errorColor,
      onPrimary: FimtoColors.onPrimaryColor,
      onSecondary: FimtoColors.onSecondaryColor,
      onSurface: FimtoColors.onSurfaceColor,
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      color: FimtoColors.primaryColor,
      fontSize: 22,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.normal,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headline4: TextStyle(
      color: FimtoColors.errorColor,
      fontSize: 24,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    headline5: TextStyle(
      color: FimtoColors.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    headline6: TextStyle(
      color: FimtoColors.primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Color(0x8a000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xff000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: TextStyle(
      color: FimtoColors.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
  ),
  accentTextTheme: TextTheme(
    headline1: TextStyle(
      color: FimtoColors.primaryTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: FimtoColors.hintColor,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: FimtoColors.errorColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: 2,
    isDense: false,
    contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: FimtoColors.iconsColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: FimtoColors.iconsColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: FimtoColors.iconsColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    fillColor: Color(0xffebf2ff),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: FimtoColors.errorColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: FimtoColors.textFieldBorderColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: FimtoColors.errorColor,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: FimtoColors.textFieldBorderColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: FimtoColors.textFieldBorderColor,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        style: BorderStyle.solid,
        color: FimtoColors.textFieldBorderColor,
      ),
    ),
  ),
  iconTheme: IconThemeData(color: FimtoColors.iconsColor, size: 26),
  primaryIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  accentIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
    side: BorderSide(
      color: Color(0xffffff),
      width: 0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  )),
  primaryTextTheme: TextTheme(
    headline6: TextStyle(color: FimtoColors.appBarTitleColor),
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    color: Colors.transparent,
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(color: FimtoColors.appBarTitleColor),
  ),
  dividerTheme: DividerThemeData(
    thickness: 2,
    color: FimtoColors.dividerColor,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xff4285f4),
    selectionColor: Color(0xff90caf9),
    selectionHandleColor: Color(0xff64b5f6),
  ),
);

class FimtoColors {
  static const Color lightPrimaryColor = Color(0xFFef7b58);
  static const Color darkPrimaryColor = Color(0xFFe63a19);
  static const Color primaryColor = Color(0xFFe74321);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color scaffoldBackGroundColor = Color(0xFFFAFAFC);
  static const Color shadowColor = Color(0xffF2F2F2);
  static const Color dividerColor = Color(0xffd1d3d8);
  static const Color primaryTextColor = Color(0xFF20416D);
  static const Color secondaryTextColor = Color(0xFF0F62A2);
  static const Color headlineTextColor = Color(0xff0F62A2);
  static const Color appBarTitleColor = Color(0xFF0E599B);
  static const Color darktableHeaderTextColor = secondaryTextColor;
  static const Color lightTableHeaderTextColor = headlineTextColor;
  static const Color textFieldBorderColor = Color(0xffd1e1f3);
  static const Color iconsColor = Color(0xff1693c6);
  static const Color successColor = Color(0xFF0BAF4D);
  static const Color surfaceColor = Color(0xFFf1f6ff);
  static const Color secondaryColor = Color(0XFF0BAF4D);
  static const Color filledFieldColor = Color(0xFFfffac3);
  static const Color onSecondaryColor = Color(0xFFFFFFFF);
  static const Color hintColor = Color(0xFF8597B1);
  static const Color darkHintColor = Color(0xFF707070);
  static const Color disabledColor = Color(0xFFB3B3B3);
  static const Color errorColor = Color(0xFFF82355);
  static const Color onErrorColor = Colors.white;
  static const Color onSurfaceColor = Color(0xFF1D1D1D);
  static const Color accentColor = Color(0xFF0BAF4D);
  static const Color warningLight = Color(0xFFFEEDC5);
  static const Color warningDark = Color(0xFFFCBA03);

  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF051c6c),
      Color(0xFF0d498f),
      Color(0xFF1373af),
      Color(0xFF1baeda),
    ],
  );
  static const LinearGradient buttonLinearGradient = LinearGradient(
    colors: [
      Color(0xFFf0805d),
      Color(0xFFed704e),
      Color(0xFFeb5d3b),
      Color(0xFFe94e2c),
      Color(0xFFe73b1a),
    ],
  );
}
