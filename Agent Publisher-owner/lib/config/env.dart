/// Environment configuration.
///
/// Loads environment variables for:
/// - Supabase URL & Anon Key
/// - Stripe Publishable Key
/// - Flutterwave Public Key
/// - Google Maps API Key
///
/// Uses --dart-define or .env approach.
class Env {
  // Load from --dart-define at build time
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'YOUR_SUPABASE_URL',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'YOUR_SUPABASE_ANON_KEY',
  );
  
  static const String stripePublishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: 'YOUR_STRIPE_KEY',
  );
  
  static const String flutterwavePublicKey = String.fromEnvironment(
    'FLUTTERWAVE_PUBLIC_KEY',
    defaultValue: 'YOUR_FLUTTERWAVE_KEY',
  );
  
  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: 'YOUR_GOOGLE_MAPS_KEY',
  );
  
  static const bool isDevelopment = bool.fromEnvironment(
    'DEBUG',
    defaultValue: true,
  );
}
