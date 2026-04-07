import 'dart:developer';

import 'package:{{projectName}}/core/core.dart';
import 'package:{{projectName}}/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ---------------------------------------------------------------------------
// Route paths — use these constants everywhere instead of raw strings so
// deep-link refactors are a single-file change.
// ---------------------------------------------------------------------------
final class AppRoutes {
  static const home = '/';
  static const login = '/login';
}

// ---------------------------------------------------------------------------
// Router factory
//
// Deep linking (Android / iOS) is handled automatically by go_router for any
// path defined in [_routes].  Native setup required:
//   • Android: add <intent-filter> with your scheme in AndroidManifest.xml
//   • iOS:     add CFBundleURLTypes (custom scheme) or Associated Domains
//              (Universal Links) in Info.plist
// ---------------------------------------------------------------------------
final class AppRouter {
  /// Creates a [GoRouter] instance.  Call **after** [configureDependencies]
  /// so that [AuthNotifier] is already registered in GetIt.
  static GoRouter create() => GoRouter(
        navigatorKey: AppKeys.navigatorKey,
        debugLogDiagnostics: kDebugMode,
        initialLocation: AppRoutes.home,
        refreshListenable: getIt<AuthNotifier>(),
        redirect: _authGuard,
        observers: [_AppRouteObserver()],
        routes: _routes,
        errorBuilder: (context, state) => _ErrorScreen(error: state.error),
      );

  // -------------------------------------------------------------------------
  // Auth guard — re-evaluated whenever [AuthNotifier] calls notifyListeners()
  // -------------------------------------------------------------------------
  static String? _authGuard(BuildContext context, GoRouterState state) {
    final isAuthenticated = getIt<AuthNotifier>().isAuthenticated;
    final isGoingToLogin = state.matchedLocation == AppRoutes.login;

    if (!isAuthenticated && !isGoingToLogin) return AppRoutes.login;
    if (isAuthenticated && isGoingToLogin) return AppRoutes.home;
    return null;
  }

  // -------------------------------------------------------------------------
  // Route definitions
  // -------------------------------------------------------------------------
  static final List<RouteBase> _routes = [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      pageBuilder: (context, state) => _buildPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      pageBuilder: (context, state) => _buildPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
  ];

  // -------------------------------------------------------------------------
  // Shared page transition — fade, respects AnimationDurations constants
  // -------------------------------------------------------------------------
  static CustomTransitionPage<void> _buildPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: AnimationDurations.fastest,
      reverseTransitionDuration: AnimationDurations.fastest,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Navigator observer — logs route changes for debugging
// ---------------------------------------------------------------------------
class _AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('→ push: ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('← pop:  ${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('⇄ replace: ${oldRoute?.settings.name} → ${newRoute?.settings.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

// ---------------------------------------------------------------------------
// 404 / error screen
// ---------------------------------------------------------------------------
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Text(error?.toString() ?? '404 – route not found'),
      ),
    );
  }
}
