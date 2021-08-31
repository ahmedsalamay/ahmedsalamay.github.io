import 'dart:async';
import 'package:fimto_frame/repository/local/token_local_repository.dart';
import 'package:fimto_frame/repository/remote/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:fimto_frame/providers.dart';
import 'package:fimto_frame/routes/router.dart';
import 'package:fimto_frame/routes/router_names.dart';
import 'package:fimto_frame/themes/theme.dart';
import 'models/language.dart';
import 'generated/l10n.dart';
import 'repository/local/language_local_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await _initializeFlutterFire();

  // if (kIsWeb) {
  //   // initialiaze the facebook javascript SDK
  //   FacebookAuth.i.webInitialize(
  //     appId: "420524549277950", //<-- YOUR APP_ID
  //     cookie: true,
  //     xfbml: true,
  //     version: "v11.0",
  //   );
  // }

  var currentLanguage = await LanguageLocalRepository().getSavedLaunage();

  var tokenRepository = TokenLocalRepository();
  await tokenRepository.initDatabase();
  final preferences = await Preferences.getInstance();
  final showOnBoardScreen = preferences.getIsFirstLaunch() && !kIsWeb;
  var isUserLoggedIn = preferences.getIsLogged();

  //setUrlStrategy(PathUrlStrategy());

  runZonedGuarded(() {
    runApp(
      ChangeNotifierProvider(
        create: (context) => currentLanguage,
        child: Consumer<Language>(
          builder: (context, provider, child) => MyApp(
            isUserLogged: isUserLoggedIn,
            isFirstLaunch: showOnBoardScreen,
          ),
        ),
      ),
    );
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    //FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
//  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final bool isUserLogged;
  final bool isFirstLaunch;

  const MyApp(
      {Key? key, required this.isUserLogged, required this.isFirstLaunch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: const [
          //FirebaseAnalyticsObserver(analytics: analytics),
        ],
        key: Key("app-" + context.watch<Language>().currentLocale.languageCode),
        supportedLocales: const [
          Locale(Language.englishCode),
          Locale(Language.arabicCode),
        ],
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: context.watch<Language>().currentLocale,
        title: 'Fimto',
        theme: myTheme,
<<<<<<< HEAD
        initialRoute:
            chooseFrameRoute, // isUserLogged ? homeRoute : loginRoute,
=======
        initialRoute: isFirstLaunch
            ? onBoardRoute
            : isUserLogged
                ? homeRoute
                : loginRoute,
>>>>>>> 54a93659219c9e8196dd1ee9c12c688d7a3a9de0
        onGenerateRoute: onGenerateRoute,
        defaultTransition: Transition.fade,
        opaqueRoute: Get.isOpaqueRouteDefault,
      ),
    );
  }
}
/*
Future<void> _initializeFlutterFire() async {
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);

  // Pass all uncaught errors to Crashlytics.
  Function originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    // Forward to original handler.
    originalOnError(errorDetails);
  };

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);
}*/
