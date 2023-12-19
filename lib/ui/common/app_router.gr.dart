// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter({
    GlobalKey<NavigatorState>? navigatorKey,
    required this.checkIfConfigExists,
  }) : super(navigatorKey);

  final CheckIfConfigExists checkIfConfigExists;

  @override
  final Map<String, PageFactory> pagesMap = {
    OnBoardingPageScreenRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const OnBoardingPageScreen(),
      );
    },
    FeelSafeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FeelSafeScreenRouteArgs>(
          orElse: () => const FeelSafeScreenRouteArgs());
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: FeelSafeScreen(
          key: args.key,
          emailSubmit: args.emailSubmit,
        ),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const HomeScreen()),
      );
    },
    TunnelDetailsRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: TunnelDetails(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          OnBoardingPageScreenRoute.name,
          path: '/',
          guards: [checkIfConfigExists],
        ),
        RouteConfig(
          FeelSafeScreenRoute.name,
          path: '/feel-safe-screen',
        ),
        RouteConfig(
          HomeScreenRoute.name,
          path: '/home-screen',
        ),
        RouteConfig(
          TunnelDetailsRoute.name,
          path: '/tunnel-details',
        ),
      ];
}

/// generated route for
/// [OnBoardingPageScreen]
class OnBoardingPageScreenRoute extends PageRouteInfo<void> {
  const OnBoardingPageScreenRoute()
      : super(
          OnBoardingPageScreenRoute.name,
          path: '/',
        );

  static const String name = 'OnBoardingPageScreenRoute';
}

/// generated route for
/// [FeelSafeScreen]
class FeelSafeScreenRoute extends PageRouteInfo<FeelSafeScreenRouteArgs> {
  FeelSafeScreenRoute({
    Key? key,
    bool emailSubmit = false,
  }) : super(
          FeelSafeScreenRoute.name,
          path: '/feel-safe-screen',
          args: FeelSafeScreenRouteArgs(
            key: key,
            emailSubmit: emailSubmit,
          ),
        );

  static const String name = 'FeelSafeScreenRoute';
}

class FeelSafeScreenRouteArgs {
  const FeelSafeScreenRouteArgs({
    this.key,
    this.emailSubmit = false,
  });

  final Key? key;

  final bool emailSubmit;

  @override
  String toString() {
    return 'FeelSafeScreenRouteArgs{key: $key, emailSubmit: $emailSubmit}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: '/home-screen',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [TunnelDetails]
class TunnelDetailsRoute extends PageRouteInfo<void> {
  const TunnelDetailsRoute()
      : super(
          TunnelDetailsRoute.name,
          path: '/tunnel-details',
        );

  static const String name = 'TunnelDetailsRoute';
}
