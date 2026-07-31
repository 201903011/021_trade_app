// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'services/global_service.dart' as _i448;
import 'services/localization_service.dart' as _i468;
import 'services/log_out_services.dart' as _i373;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i448.GlobalService>(() => _i448.GlobalService());
    gh.singleton<_i468.LocalizationService>(() => _i468.LocalizationService());
    gh.singleton<_i373.LogOutServices>(
        () => _i373.LogOutServices(globalService: gh<_i448.GlobalService>()));
    return this;
  }
}
