import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:fimto_frame/repository/local/language_local_repository.dart';
import 'package:fimto_frame/services/connection_service.dart';
import '../repository/local/token_local_repository.dart';
import '../repository/remote/token_repository.dart';
import '../services/message_service.dart';
import '../services/token_services.dart';

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
  ProxyProvider2<TokenRepository, TokenLocalRepository, TokenService>(
    update: (_, TokenRepository identityRepository,
            TokenLocalRepository tokenLocalRepository, __) =>
        TokenService(identityRepository, tokenLocalRepository),
    lazy: true,
  ),
];
