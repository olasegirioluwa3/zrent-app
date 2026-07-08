# ZRent Agent Publisher

A Flutter application for property agents to publish and manage rental properties.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- A Supabase project

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Agent Publisher-owner
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**

   Create a Supabase project at [supabase.com](https://supabase.com):
   - Go to Project Settings → API
   - Copy your Project URL and Anon Key

   Create a `.env` file in the project root:
   ```bash
   cp .env.example .env
   ```

   Edit `.env` with your credentials:
   ```
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
   FLUTTERWAVE_PUBLIC_KEY=your_flutterwave_public_key
   GOOGLE_MAPS_API_KEY=your_google_maps_api_key
   DEBUG=true
   ```

4. **Run the app**
   ```bash
   flutter run -d chrome
   ```

   Or for mobile:
   ```bash
   flutter run
   ```

## Authentication

The app uses Supabase for authentication. The auth flow includes:
- **Sign Up**: Users can create an account with email and password
- **Login**: Users can login with their credentials
- **Auth Guard**: Protected routes redirect unauthenticated users to login
- **Auto-login**: Authenticated users are redirected to dashboard on app launch

### Auth Routes
- `/splash` - Splash screen (auto-redirects based on auth state)
- `/get-started` - Welcome screen with login/signup options
- `/login` - Login screen
- `/register` - Sign up screen

### Protected Routes
All dashboard and feature routes require authentication:
- `/dashboard` - Main dashboard
- `/properties` - Property management
- `/messages` - Messaging
- `/wallet` - Wallet and withdrawals
- `/profile` - User profile
- And more...

## Project Structure

```
lib/
├── core/
│   ├── router/          # Navigation and routing
│   ├── theme/           # App theming
│   └── config/          # Configuration files
├── features/
│   ├── auth/            # Authentication
│   ├── dashboard/       # Dashboard
│   ├── properties/      # Property management
│   ├── messages/        # Messaging
│   ├── wallet/          # Wallet and payments
│   └── verification/    # User verification
└── main.dart            # App entry point
```

## Development

### Running tests
```bash
flutter test
```

### Building for production
```bash
flutter build web
```

### Code generation
```bash
flutter pub run build_runner build
```

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Flutter](https://supabase.com/docs/guides/getting-started/tutorials/with-flutter)
- [Riverpod Documentation](https://riverpod.dev/)
- [GoRouter Documentation](https://gorouter.dev/)
