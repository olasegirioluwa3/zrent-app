/// Supabase client initialization.
///
/// Initializes Supabase with URL and Anon Key from Env.
/// Called during bootstrap().
class SupabaseConfig {
  // TODO: Replace with actual Supabase credentials
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'YOUR_SUPABASE_URL',
  );
  
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'YOUR_SUPABASE_ANON_KEY',
  );
}
