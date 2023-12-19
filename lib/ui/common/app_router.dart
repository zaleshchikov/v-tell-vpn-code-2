import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wireguard_flutter/shared_preferences.dart';
import 'package:wireguard_flutter/ui/feel_safe_screen.dart';
import 'package:wireguard_flutter/ui/home_screen/home_screen.dart';
import 'package:wireguard_flutter/ui/onboarding_page_screen.dart';
import 'package:wireguard_flutter/ui/tunnel_details.dart';

part 'app_router.gr.dart';

class CheckIfConfigExists extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {

    var isConfigDataStored = await MySharedPreferences().getConfigString();
    // print('isConfigDataStored');
    // print(isConfigDataStored);
    if (isConfigDataStored != null) {
      router.push(TunnelDetailsRoute()); // config was found. proceed to the TunnelDetailsRoute page
    }else {
      resolver.next(true); // config was not found. proceed to the Onboarding page
    }
  }
}

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen,Provider',
  routes: <AutoRoute>[
    CupertinoRoute(page: OnBoardingPageScreen, initial: true, guards: [CheckIfConfigExists]),
    CupertinoRoute(page: FeelSafeScreen),
    CupertinoRoute(page: HomeScreen),
    CupertinoRoute(page: TunnelDetails),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter{
  AppRouter({required CheckIfConfigExists checkIfConfigExists}) : super(checkIfConfigExists: CheckIfConfigExists());
}