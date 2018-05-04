class MyException implements Exception {
  String _message;

  MyException(this._message);

  String toString() {
    return this._message;
  }
}