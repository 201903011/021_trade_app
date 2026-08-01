import 'package:minimals/config/config_data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:minimals/injection.config.dart';
import 'package:minimals/services/localization_service.dart';
import 'package:minimals/config/config.dart';
import 'package:minimals/config/models/app_config.dart' as config_models;
import 'package:minimals/enum/environment.dart' as env;

final getIt = GetIt.instance;

/// Helper function to map AppEnvironment to Environment
config_models.Environment _mapAppEnvironmentToEnvironment(env.AppEnvironment appEnv) {
  switch (appEnv) {
    case env.AppEnvironment.dev:
      return config_models.Environment.development;
    case env.AppEnvironment.uat:
      return config_models.Environment.staging;
    case env.AppEnvironment.prod:
      return config_models.Environment.production;
  }
}

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  ignoreUnregisteredTypes: [],
)
Future<void> configureDependencies(env.AppEnvironment envFlav) async {
  // Get the appropriate default config for the environment
  final environment = _mapAppEnvironmentToEnvironment(envFlav);
  final defaultConfig = getConfigByEnvironment(environment);
  // Create and initialize config with the environment-specific defaults
  final config = await Config(defaultConfigData: defaultConfig).init();

  // Register the config instance
  getIt.registerSingleton<Config>(config);
  getIt.init(environment: envFlav.toString());
  // Register LocalizationService if not already registered
  if (!getIt.isRegistered<LocalizationService>()) {
    getIt.registerSingleton<LocalizationService>(LocalizationService());
  }
}
