class ObjectModelNotFoundException implements Exception {
  final String id;

  ObjectModelNotFoundException({required this.id}) : super();

  @override
  String toString() {
    return 'Object with id = $id was not found';
  }
}
