import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@sealed
abstract class DeploymentEnvironment {
  DeploymentEnvironment._();

  static const String integration = 'integration';
  static const String development = 'development';
  static const String staging = 'staging';
  static const String production = 'production';

  static const List<String> values = <String>[
    integration,
    development,
    staging,
    production,
  ];

  static String? _current;
  static String get current => _current ??= () {
        const flavor = String.fromEnvironment('environment');
        final env =
            DeploymentEnvironment.values.firstWhereOrNull((e) => e == flavor);
        if (env != null) {
          return env;
        }
        if (kProfileMode) {
          return staging;
        } else if (kDebugMode) {
          return development;
        } else if (kReleaseMode) {
          return production;
        }
        return integration;
      }();

  // ignore: use_setters_to_change_properties
  static void setEnvironment(String environment) => _current =
      DeploymentEnvironment.values.firstWhereOrNull((e) => e == environment) ??
          _current;

  static T map<T>({
    required T Function() integration,
    required T Function() development,
    required T Function() staging,
    required T Function() production,
  }) {
    switch (current) {
      case DeploymentEnvironment.integration:
        return integration();
      case DeploymentEnvironment.development:
        return development();
      case DeploymentEnvironment.staging:
        return staging();
      case DeploymentEnvironment.production:
        return production();
      default:
        assert(false, 'Unknown environment: $current');
        return production();
    }
  }

  static T maybeMap<T>({
    required T Function() orElse,
    T Function()? integration,
    T Function()? development,
    T Function()? staging,
    T Function()? production,
  }) =>
      map<T>(
        integration: integration ?? orElse,
        development: development ?? orElse,
        staging: staging ?? orElse,
        production: production ?? orElse,
      );

  static T? mapOrNull<T>({
    T Function()? integration,
    T Function()? development,
    T Function()? staging,
    T Function()? production,
  }) =>
      maybeMap<T?>(
        orElse: () => null,
        integration: integration,
        development: development,
        staging: staging,
        production: production,
      );
}
