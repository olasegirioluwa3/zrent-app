import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'route_names.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/get_started_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/properties/presentation/screens/property_location_screen.dart';
import '../../features/properties/presentation/screens/property_details_screen.dart';
import '../../features/properties/presentation/screens/property_preview_screen.dart';
import '../../features/properties/presentation/screens/property_pricing_screen.dart';
import '../../features/properties/presentation/screens/publish_success_screen.dart';
import '../../features/wallet/presentation/screens/wallet_screen.dart';
import '../../features/withdrawals/presentation/screens/withdraw_screen.dart';
import '../../features/withdrawals/presentation/screens/withdraw_pin_screen.dart';
import '../../features/withdrawals/presentation/screens/withdrawal_success_screen.dart';
import '../../features/withdrawals/presentation/screens/select_bank_screen.dart';
import '../../features/withdrawals/presentation/screens/set_pin_screen.dart';
import '../../features/verification/presentation/screens/verification_dashboard_screen.dart';
import '../../features/verification/presentation/screens/get_verified_screen.dart';
import '../../features/verification/presentation/screens/document_scan_screen.dart';
import '../../features/verification/presentation/screens/tier_upgrade_screen.dart';
import '../../features/verification/presentation/screens/verification_submitted_screen.dart';
import '../../features/messages/presentation/screens/messages_screen.dart';
import '../../features/messages/presentation/screens/open_chat_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/subscription_screen.dart';
import '../router/guards/auth_guard.dart';
import '../../features/auth/application/providers/auth_provider.dart';

/// GoRouter configuration for Agent App.
///
/// Defines:
/// - Route tree with nested shell routes for bottom nav
/// - Auth redirect logic
/// - Route guards
///
/// Structure:
///   /splash
///   /get-started
///   /login
///   /register
///   /dashboard (with bottom nav)
///   /orders
///   /properties/location
///   /properties/details
///   /properties/preview
///   /properties/pricing
///   /properties/success
///   /wallet
///   /wallet/withdraw
///   /wallet/withdraw-pin
///   /wallet/withdrawal-success
///   /wallet/select-bank
///   /wallet/set-pin
///   /verification/dashboard
///   /verification/get-verified
///   /verification/document-scan
///   /verification/tier-upgrade
///   /messages
///   /chat
///   /notifications
///   /profile

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    // Auth guard disabled - allow access without authentication
    // redirect: (context, state) => AuthGuard.redirect(ref, state),
    routes: [
      // Auth Flow
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.getStarted,
        name: RouteNames.getStarted,
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: RouteNames.register,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      
      // Main Dashboard with Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.dashboard,
                name: RouteNames.dashboard,
                builder: (context, state) => const DashboardHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.properties,
                name: RouteNames.properties,
                builder: (context, state) => const PropertiesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.messages,
                name: RouteNames.messages,
                builder: (context, state) => const MessagesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.wallet,
                name: RouteNames.wallet,
                builder: (context, state) => const WalletScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                name: RouteNames.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      
      // Orders
      GoRoute(
        path: RouteNames.orders,
        name: RouteNames.orders,
        builder: (context, state) => const OrdersScreen(),
      ),
      
      // Property Flow
      GoRoute(
        path: RouteNames.propertyLocation,
        name: RouteNames.propertyLocation,
        builder: (context, state) => const PropertyLocationScreen(),
      ),
      GoRoute(
        path: RouteNames.propertyDetails,
        name: RouteNames.propertyDetails,
        builder: (context, state) => const PropertyDetailsScreen(),
      ),
      GoRoute(
        path: RouteNames.propertyPreview,
        name: RouteNames.propertyPreview,
        builder: (context, state) => const PropertyPreviewScreen(),
      ),
      GoRoute(
        path: RouteNames.propertyPricing,
        name: RouteNames.propertyPricing,
        builder: (context, state) => const PropertyPricingScreen(),
      ),
      GoRoute(
        path: RouteNames.publishSuccess,
        name: RouteNames.publishSuccess,
        builder: (context, state) => const PublishSuccessScreen(),
      ),
      
      // Wallet & Withdrawals
      GoRoute(
        path: RouteNames.requestWithdrawal,
        name: RouteNames.requestWithdrawal,
        builder: (context, state) => const WithdrawScreen(),
      ),
      GoRoute(
        path: RouteNames.withdrawPin,
        name: RouteNames.withdrawPin,
        builder: (context, state) => const WithdrawPinScreen(),
      ),
      GoRoute(
        path: RouteNames.withdrawalSuccess,
        name: RouteNames.withdrawalSuccess,
        builder: (context, state) => const WithdrawalSuccessScreen(),
      ),
      GoRoute(
        path: RouteNames.selectBank,
        name: RouteNames.selectBank,
        builder: (context, state) => const SelectBankScreen(),
      ),
      GoRoute(
        path: RouteNames.setPin,
        name: RouteNames.setPin,
        builder: (context, state) => const SetPinScreen(),
      ),
      
      // Verification
      GoRoute(
        path: RouteNames.verificationDashboard,
        name: RouteNames.verificationDashboard,
        builder: (context, state) => const VerificationDashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.getVerified,
        name: RouteNames.getVerified,
        builder: (context, state) => const GetVerifiedScreen(),
      ),
      GoRoute(
        path: RouteNames.documentScan,
        name: RouteNames.documentScan,
        builder: (context, state) => const DocumentScanScreen(),
      ),
      GoRoute(
        path: RouteNames.tierUpgrade,
        name: RouteNames.tierUpgrade,
        builder: (context, state) => const TierUpgradeScreen(),
      ),
      GoRoute(
        path: RouteNames.verificationSubmitted,
        name: RouteNames.verificationSubmitted,
        builder: (context, state) => const VerificationSubmittedScreen(),
      ),
      
      // Messages
      GoRoute(
        path: RouteNames.openChat,
        name: RouteNames.openChat,
        builder: (context, state) => const OpenChatScreen(),
      ),
      
      // Notifications
      GoRoute(
        path: RouteNames.notifications,
        name: RouteNames.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      
      // Settings
      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      
      // Subscription
      GoRoute(
        path: RouteNames.subscription,
        name: RouteNames.subscription,
        builder: (context, state) => const SubscriptionScreen(),
      ),
    ],
  );
});
