import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:minimals/routes/auth_routes.dart';
import 'package:minimals/screens/dashboard/controller/dashboard_controller.dart';
import 'package:minimals/screens/dashboard/dashboard_main.dart';
import 'package:minimals/screens/funds/controller/funds_controller.dart';
import 'package:minimals/screens/funds/funds_main.dart';
import 'package:minimals/screens/holdings/controller/holding_controller.dart';
import 'package:minimals/screens/holdings/holding_main.dart';
import 'package:minimals/screens/initial/initial.dart';
import 'package:minimals/screens/login/login_view.dart';
import 'package:minimals/screens/watchlist/controller/watching_controller.dart';
import 'package:minimals/screens/watchlist/watching_main.dart';
import 'package:minimals/widget/bottom_tabs/botton_tabs_controller.dart';

abstract class Routes {
  static const initial = '/initial';
  static const login = '/login';
  static const settings = '/settings';

  // Dashboard route
  static const dashboard = '/dashboard';

  // Exchange route
  static const exchangeMain = '/exchange';

  // Holdings route
  static const holdings = '/holdings';

  // Watchlist route
  static const watchlist = '/watchlist';

  // Funds route
  static const funds = '/funds';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.initial,
      // page: () => const LoadingScreen(),
      page: () => const InitialScreen(),
      // binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
    ),
    GetPage(
      bindings: [],
      name: Routes.dashboard,
      page: () {
        return DashboardMain();
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 10),
      binding: BindingsBuilder(() {
        Get.put(DashboardMainController());
        final bottomTabController = Get.put(BottomTabsController());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          bottomTabController.changeValue(0);
        });
      }),
    ),
    GetPage(
      bindings: [],
      name: Routes.holdings,
      page: () {
        return HoldingMain();
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 10),
      binding: BindingsBuilder(() {
        Get.put(HoldingMainController());
        final bottomTabController = Get.put(BottomTabsController());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          bottomTabController.changeValue(1);
        });
      }),
    ),
    GetPage(
      bindings: [],
      name: Routes.watchlist,
      page: () {
        return WatchlistMain();
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 10),
      binding: BindingsBuilder(() {
        Get.put(WatchListMainController());
        final bottomTabController = Get.put(BottomTabsController());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          bottomTabController.changeValue(2);
        });
      }),
    ),
    GetPage(
      bindings: [],
      name: Routes.funds,
      page: () {
        return FundsMain();
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 10),
      binding: BindingsBuilder(() {
        Get.put(FundsMainController());
        final bottomTabController = Get.put(BottomTabsController());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          bottomTabController.changeValue(3);
        });
      }),
    ),
    ...AuthPages.routes,
  ];
}
