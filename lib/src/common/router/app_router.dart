import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../feature/game/model/game_board_size.dart';
import '../../feature/game/model/game_speed.dart';
import 'app_guard.dart';
import 'app_routes.dart';

/// {@template app_router}
/// AppRouter
/// {@endtemplate}
@Singleton()
class AppRouter with _InitializationMixin, _StateMixin, _GoMixin {
  AppRouter._();
  static AppRouter? _instance;
  // ignore: prefer_constructors_over_static_methods
  @factoryMethod
  factory AppRouter.instance() => _instance ??= AppRouter._();
}

/// Go router initialization mixin
mixin _InitializationMixin {
  final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();
  NavigatorState? get navigator => routeObserver.navigator;
  late final GoRouter _goRouter = _buildRouter();
  final AppGuard _guard = AppGuard();
  bool get isReady => navigator != null;

  GoRouter _buildRouter() => GoRouter(
        restorationScopeId: 'app_router',
        routes: appRoutes,
        refreshListenable: _guard,
        redirect: _guard,
        redirectLimit: 5,
        //errorBuilder: (context, state) => NotFoundRoute(exception: state.error).build(context),
        //navigatorBuilder: ,
        observers: <NavigatorObserver>[
          routeObserver,
          // TODO: Add own Firebase Analytucs navigator observer
          // like: FirebaseAnalytics.instanceObserver(analytics: FirebaseAnalytics.instance.instance),
        ],
      );
}

/// Current router state mixin
mixin _StateMixin on _InitializationMixin {
  final RootBackButtonDispatcher backButtonDispatcher = RootBackButtonDispatcher();
  RouterDelegate<List<Object>> get routerDelegate => _goRouter.routerDelegate;
  RouteInformationParser<List<Object>> get routeInformationParser => _goRouter.routeInformationParser;
  RouteInformationProvider get routeInformationProvider => _goRouter.routeInformationProvider;
  String get location => _goRouter.location;
  Map<String, String> get queryParameters => Uri.parse(location).queryParameters;
}

/// Available routes methods mixin
mixin _GoMixin on _StateMixin {
  void goMenu() => _goRouter.goNamed('menu');
  void goSettings() => _goRouter.goNamed('settings');
  void goScore() => _goRouter.goNamed('score');
  void goAuthentication() => _goRouter.goNamed('authentication');
  void goGame(GameBoardSize size, GameSpeed speed) => _goRouter.goNamed(
        'game',
        params: <String, String>{
          'size': size.value,
          'speed': speed.value,
        },
      );
}
