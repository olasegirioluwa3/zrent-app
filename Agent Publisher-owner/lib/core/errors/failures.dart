/// Base failure class for error handling.
abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});
}

/// Server-side failures (Supabase, API errors).
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Local cache/storage failures.
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Network connectivity failures.
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

/// Authentication failures.
class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

/// Payment processing failures.
class PaymentFailure extends Failure {
  const PaymentFailure({required super.message});
}
