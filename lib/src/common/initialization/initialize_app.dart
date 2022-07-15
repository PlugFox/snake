import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:l/l.dart';

import '../constant/deployment_environment.dart';
import 'initialize_app.config.dart';

Future<void> initializeApp({
  String? environment,
  GetIt? getIt,
  void Function(Duration duration)? onSuccessful,
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  final stopwatch = Stopwatch()..start();
  late final WidgetsBinding binding;
  try {
    binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
    final container = getIt ?? GetIt.instance;
    //await Firebase.initializeApp(
    //  options: DefaultFirebaseOptions.currentPlatform,
    //);
    await _injectDependencies(
      container,
      environment: environment ?? DeploymentEnvironment.current,
    );
    //container<FirebaseAnalytics>().logAppOpen();
    binding.renderViewElement;
    await _authenticationInitilization(container);
    onSuccessful?.call(stopwatch.elapsed);
  } on Object catch (error, stackTrace) {
    onError?.call(error, stackTrace);
    rethrow;
  } finally {
    stopwatch.stop();
    binding.addPostFrameCallback((_) {
      // Closes splash screen, and show the app layout.
      binding.allowFirstFrame();
      // binding.renderViewElement context
    });
  }
}

@InjectableInit(
  asExtension: true,
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  usesNullSafety: true,
)
Future<GetIt> _injectDependencies(
  GetIt getIt, {
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  l.d('_initializeApp');
  final container = await getIt.$initGetIt(
    environment: environment,
    environmentFilter: environmentFilter,
  );
  await container.allReady(timeout: const Duration(seconds: 15));
  l.i('GetIt initialized');
  return container;
}

Future<void> _authenticationInitilization(GetIt container) async {
  /*
  final auth = container<FirebaseAuth>();
  if (auth.currentUser != null) return;
  try {
    await auth.userChanges().first.timeout(const Duration(seconds: 1));
  } on TimeoutException {
    l.d('No user found at initialization stage');
  }
  */
}
