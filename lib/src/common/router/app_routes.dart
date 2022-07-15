import 'package:go_router/go_router.dart';

import '../../feature/authentication/widget/sign_in_screen.dart';
import '../../feature/game/model/game_board_size.dart';
import '../../feature/game/model/game_speed.dart';
import '../../feature/game/widget/game_screen.dart';
import '../../feature/menu/widget/menu_screen.dart';
import '../../feature/score/widget/score_screen.dart';
import '../../feature/settings/widget/settings_screen.dart';

final List<GoRoute> appRoutes = <GoRoute>[
  // Home
  GoRoute(
    name: 'home',
    path: '/',
    redirect: (state) => state.namedLocation(
      'menu',
      queryParams: state.queryParams,
    ),
  ),

  // MenuScreen
  GoRoute(
    name: 'menu',
    path: '/menu',
    builder: (context, state) => MenuScreen(
      key: state.pageKey,
    ),
    routes: <GoRoute>[
      GoRoute(
        name: 'settings',
        path: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: 'score',
        path: 'score',
        builder: (context, state) => const ScoreScreen(),
      ),
      GoRoute(
        name: 'authentication',
        path: 'authentication',
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  ),

  // Game
  GoRoute(
    name: 'game',
    path: '/game/:size/:speed',
    builder: (context, state) => GameScreen(
      size: GameBoardSize.fromValue(
        state.params['size'],
        fallback: GameBoardSize.medium,
      ),
      speed: GameSpeed.fromValue(
        state.params['speed'],
        fallback: GameSpeed.medium,
      ),
    ),
  ),
];
