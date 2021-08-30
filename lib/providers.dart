import 'package:fimto_frame/models/language.dart';
import 'package:fimto_frame/repository/remote/configuration_repository.dart';
import 'package:fimto_frame/repository/remote/facebook_repository.dart';
import 'package:fimto_frame/repository/remote/instagram_repository.dart';
import 'package:fimto_frame/repository/remote/order_repository.dart';
import 'package:fimto_frame/services/request_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:fimto_frame/repository/local/language_local_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import '../repository/local/token_local_repository.dart';
import '../repository/remote/token_repository.dart';
import '../services/message_service.dart';
import '../services/token_services.dart';
import 'models/order.dart';

List<SingleChildWidget> providers = [
  Provider<LanguageLocalRepository>(
    create: (_) => LanguageLocalRepository(),
    lazy: true,
  ),
  ChangeNotifierProvider<ConnectionService>(
    create: (_) => ConnectionService(),
    lazy: true,
  ),
  Provider<TokenLocalRepository>(
    create: (_) => TokenLocalRepository(),
    lazy: true,
  ),
  Provider<MessageService>(
    create: (_) => MessageService(),
    lazy: true,
  ),
  Provider<Order>(
    create: (_) => Order(),
    lazy: true,
  ),
  ProxyProvider<Language, TokenRepository>(
    update: (_, language, __) => TokenRepository(language: language),
    lazy: true,
  ),
  ProxyProvider2<TokenRepository, TokenLocalRepository, TokenService>(
    update: (_, TokenRepository identityRepository,
            TokenLocalRepository tokenLocalRepository, __) =>
        TokenService(identityRepository, tokenLocalRepository),
    lazy: true,
  ),
  ProxyProvider2<Language, TokenService, RequestProvider>(
    update: (_, Language language, TokenService tokenService, __) =>
        RequestProvider(language: language, tokenService: tokenService),
    lazy: true,
  ),
  Provider<FacebookRepository>(
    create: (_) => FacebookRepository(),
    lazy: true,
  ),
  ProxyProvider<RequestProvider, ConfigurationRepository>(
    update: (_, requestProvider, __) =>
        ConfigurationRepository(requestProvider),
    lazy: true,
  ),
  ProxyProvider<RequestProvider, OrderRepository>(
    update: (_, requestProvider, __) => OrderRepository(requestProvider),
    lazy: true,
  ),
  ProxyProvider<RequestProvider, InstagramRepository>(
    update: (_, requestProvider, __) => InstagramRepository(),
    lazy: true,
  ),
];
