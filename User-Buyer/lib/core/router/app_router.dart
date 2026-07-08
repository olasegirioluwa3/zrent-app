/// GoRouter configuration for Buyer App.
///
/// Defines:
/// - Route tree with nested shell routes for bottom nav
/// - Auth redirect logic
/// - Route guards
///
/// Structure:
///   / (splash)
///   /login
///   /register
///   /shell (StatefulShellRoute - bottom nav)
///     ├── /home
///     ├── /discover (map discovery)
///     ├── /favorites
///     ├── /messages
///     └── /profile
///   /search
///   /property/:id
///   /agent/:id
///   /checkout
///   /payment
///   /orders
///   /notifications
///   /settings

// TODO: Implement GoRouter with StatefulShellRoute for bottom navigation
// TODO: Add AuthGuard redirect
