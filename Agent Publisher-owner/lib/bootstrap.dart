import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'config/firebase_config.dart';
import 'config/env.dart';

/// Initializes all services before app starts.
/// - Supabase
/// - Firebase (FCM)
/// - Environment config
/// - Stripe / Flutterwave
Future<void> bootstrap() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  // Initialize Firebase
  // await Firebase.initializeApp();
  // TODO: Initialize Firebase FCM

  // Load environment config
  // TODO: Load environment variables from .env file
}
