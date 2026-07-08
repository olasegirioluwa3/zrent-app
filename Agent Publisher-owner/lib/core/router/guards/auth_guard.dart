import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/application/providers/auth_provider.dart';
import '../route_names.dart';

/// Auth guard for GoRouter.
///
/// Redirects unauthenticated users to login.
/// Redirects authenticated users away from auth screens.
///
/// Listens to Supabase auth state changes via Riverpod.
class AuthGuard {
  /// Redirect logic for protected routes.
  /// 
  /// Returns null if navigation is allowed.
  /// Returns a redirect path if navigation should be intercepted.
  static String? redirect(Ref ref, GoRouterState state) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final isAuthRoute = _isAuthRoute(state.matchedLocation);
    final isProtectedRoute = _isProtectedRoute(state.matchedLocation);

    // If user is authenticated and tries to access auth routes, redirect to dashboard
    if (isAuthenticated && isAuthRoute) {
      return RouteNames.dashboard;
    }

    // If user is not authenticated and tries to access protected routes, redirect to login
    if (!isAuthenticated && isProtectedRoute) {
      return RouteNames.login;
    }

    // Allow navigation
    return null;
  }

  /// Check if the current route is an auth route (login, register, etc.)
  static bool _isAuthRoute(String location) {
    return location == RouteNames.login ||
           location == RouteNames.register ||
           location == RouteNames.getStarted ||
           location == RouteNames.splash;
  }

  /// Check if the current route is a protected route (requires authentication)
  static bool _isProtectedRoute(String location) {
    return location == RouteNames.dashboard ||
           location == RouteNames.properties ||
           location == RouteNames.messages ||
           location == RouteNames.wallet ||
           location == RouteNames.profile ||
           location == RouteNames.orders ||
           location.startsWith(RouteNames.propertyLocation) ||
           location.startsWith(RouteNames.propertyDetails) ||
           location.startsWith(RouteNames.propertyPreview) ||
           location.startsWith(RouteNames.propertyPricing) ||
           location == RouteNames.publishSuccess ||
           location.startsWith(RouteNames.requestWithdrawal) ||
           location.startsWith(RouteNames.withdrawPin) ||
           location.startsWith(RouteNames.withdrawalSuccess) ||
           location.startsWith(RouteNames.selectBank) ||
           location.startsWith(RouteNames.setPin) ||
           location.startsWith(RouteNames.verificationDashboard) ||
           location.startsWith(RouteNames.getVerified) ||
           location.startsWith(RouteNames.documentScan) ||
           location.startsWith(RouteNames.tierUpgrade) ||
           location == RouteNames.verificationSubmitted ||
           location == RouteNames.openChat ||
           location == RouteNames.notifications;
  }
}
