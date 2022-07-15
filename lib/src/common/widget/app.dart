import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../localization/localization.dart';
import '../router/app_router.dart';

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Snake',
        restorationScopeId: 'app',
        theme: ThemeData.light(),
        routeInformationParser: AppRouter.instance().routeInformationParser,
        routerDelegate: AppRouter.instance().routerDelegate,
        routeInformationProvider: AppRouter.instance().routeInformationProvider,
        localizationsDelegates: const <LocalizationsDelegate<Object?>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          Localization.delegate,
        ],
        supportedLocales: Localization.supportedLocales,
      );
} // App
