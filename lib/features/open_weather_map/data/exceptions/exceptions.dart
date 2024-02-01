class ServerException implements Exception {
  final int code;

  ServerException(this.code);

  @override
  String toString() {
    return 'Response code was $code';
  }
}