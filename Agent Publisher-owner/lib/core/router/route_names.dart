/// Route name constants for GoRouter.
///
/// All named routes for the Agent app navigation.
class RouteNames {
  // Auth
  static const String splash = '/splash';
  static const String getStarted = '/get-started';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';

  // Main (bottom nav tabs)
  static const String dashboard = '/dashboard';
  static const String properties = '/properties';
  static const String messages = '/messages';
  static const String wallet = '/wallet';
  static const String profile = '/profile';

  // Properties
  static const String propertyLocation = '/properties/location';
  static const String propertyDetails = '/properties/details';
  static const String propertyPreview = '/properties/preview';
  static const String propertyPricing = '/properties/pricing';
  static const String publishSuccess = '/properties/success';
  static const String publishProperty = '/properties/publish';
  static const String editProperty = '/properties/edit';
  static const String propertyDetail = '/properties/:id';

  // Wallet & Withdrawals
  static const String withdrawals = '/wallet/withdrawals';
  static const String requestWithdrawal = '/wallet/withdraw';
  static const String withdrawPin = '/wallet/withdraw-pin';
  static const String withdrawalSuccess = '/wallet/withdrawal-success';
  static const String selectBank = '/wallet/select-bank';
  static const String setPin = '/wallet/set-pin';

  // Verification
  static const String verification = '/verification';
  static const String verificationDashboard = '/verification/dashboard';
  static const String getVerified = '/verification/get-verified';
  static const String uploadDocument = '/verification/upload-document';
  static const String documentScan = '/verification/document-scan';
  static const String tierUpgrade = '/verification/tier-upgrade';
  static const String tierUpgrade2 = '/verification/tier-upgrade-2';
  static const String tierUpgrade3 = '/verification/tier-upgrade-3';
  static const String verificationSubmitted = '/verification/submitted';

  // Orders
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';

  // Analytics
  static const String analytics = '/analytics';

  // Subscription
  static const String subscription = '/subscription';

  // Notifications
  static const String notifications = '/notifications';

  // Settings
  static const String settings = '/settings';

  // Chat
  static const String chat = '/chat/:id';
  static const String openChat = '/chat';
}
