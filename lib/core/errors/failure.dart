class Failure {
  final String message;
  final int statusCode;

  const Failure({
    this.message = 'An unknown error occurred.',
    this.statusCode = 500,
  });

  @override
  String toString() {
    return 'Failure(message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          statusCode == other.statusCode;

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}
