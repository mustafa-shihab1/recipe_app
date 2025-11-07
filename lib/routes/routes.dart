
import 'package:flutter/material.dart';
import '../core/widgets/app_start_view.dart';
import '../features/auth/presentation/view/register_view.dart';
import '../config/dependency_injection.dart';
import '../core/resources/strings_manager.dart';
import '../features/auth/presentation/view/login_view.dart';
import '../features/main/presentation/view/main_view.dart';
import '../features/search/presentation/view/search_view.dart';

class Routes {
  static const String appStartView = '/app_start_view';
  static const String loginView = '/login_view';
  static const String registerView = '/register_view';
  static const String mainView = '/main_view';
  static const String homeView = '/home_view';
  static const String searchView = '/search_view';
  static const String exploreView = '/explore_view';
  static const String favoritesView = '/favorites_view';
  static const String profileView = '/profile_view';
}

class RouteGenerator {

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.appStartView:
        return MaterialPageRoute(builder: (_) => AppStartView());
      case Routes.loginView:
        initAuth();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerView:
        initAuth();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.mainView:
        initMain();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.searchView:
        initSearch();
        return MaterialPageRoute(builder: (_) => const SearchView());
      default:
        return unDefinedRoute();
    }
  }


  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(StringsManager.noRouteFound),
        ),
        body: Center(
          child: Text(StringsManager.noRouteFound),
        ),
      ),
    );
  }

}