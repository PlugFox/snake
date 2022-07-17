import 'package:flutter/material.dart';

import '../../../common/router/app_router.dart';
import '../../game/model/game_board_size.dart';
import '../../game/model/game_speed.dart';

// TODO: Analytics
// Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022

/// {@template menu_screen}
/// MenuScreen widget
/// {@endtemplate}
class MenuScreen extends StatelessWidget {
  /// {@macro menu_screen}
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Menu')),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Game'),
                onTap: () => AppRouter.instance().goGame(GameBoardSize.medium, GameSpeed.medium),
              ),
              // TODO: Settings, theme
              // Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022
              ListTile(
                title: const Text('Settings'),
                onTap: () => AppRouter.instance().goSettings(),
              ),
              // TODO: Score and scoreboard
              // Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022
              ListTile(
                title: const Text('Score'),
                onTap: () => AppRouter.instance().goScore(),
              ),
              // TODO: Authentication
              // Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022
              ListTile(
                title: const Text('SignIn'),
                onTap: () => AppRouter.instance().goAuthentication(),
              ),
              ListTile(
                title: const Text('License'),
                onTap: () => showLicensePage(context: context),
              ),
            ],
          ),
        ),
      );
} // MenuScreen
