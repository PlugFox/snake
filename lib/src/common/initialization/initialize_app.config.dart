// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:snake/src/common/initialization/registered_modules.dart' as _i5;
import 'package:snake/src/common/router/app_router.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  Future<_i1.GetIt> $initGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final registeredModules = _$RegisteredModules();
    gh.singleton<_i3.AppRouter>(_i3.AppRouter.instance());
    await gh.factoryAsync<_i4.SharedPreferences>(
        () => registeredModules.sharedPreferences,
        preResolve: true);
    return this;
  }
}

class _$RegisteredModules extends _i5.RegisteredModules {}
