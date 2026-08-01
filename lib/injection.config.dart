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

import 'locale/enhanced_localization_service.dart' as _i901;
import 'screens/holdings/repository/holding_repository.dart' as _i485;
import 'screens/holdings/repository/order_repository.dart' as _i734;
import 'screens/holdings/repository/wallet_repository.dart' as _i559;
import 'screens/watchlist/repository/watchlist_repository.dart' as _i666;
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
    gh.singleton<_i901.EnhancedLocalizationService>(
        () => _i901.EnhancedLocalizationService());
    gh.singleton<_i485.HoldingRepository>(() => _i485.HoldingRepository());
    gh.singleton<_i734.OrderRepository>(() => _i734.OrderRepository());
    gh.singleton<_i559.WalletRepository>(() => _i559.WalletRepository());
    gh.singleton<_i666.WatchlistRepository>(() => _i666.WatchlistRepository());
    gh.singleton<_i448.GlobalService>(() => _i448.GlobalService());
    gh.singleton<_i468.LocalizationService>(() => _i468.LocalizationService());
    gh.singleton<_i373.LogOutServices>(
        () => _i373.LogOutServices(globalService: gh<_i448.GlobalService>()));
    return this;
  }
}
