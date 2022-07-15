import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

import 'src/common/initialization/initialize_app.dart';
import 'src/common/widget/app.dart';

void main() => runZonedGuarded<void>(
      () => l.capture<void>(
        () => initializeApp(
          onSuccessful: (_) => runApp(const App()),
          onError: (_, __) {},
        ),
        const LogOptions(
          handlePrint: true,
          outputInRelease: true,
          printColors: true,
        ),
      ),
      l.e,
    );
