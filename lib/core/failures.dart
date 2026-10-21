/// Failure surfaced from data/infra to presentation with a user-facing message.
class AppFailure implements Exception {
  const AppFailure(this.message);

  final String message;

  @override
  String toString() => message;
}
