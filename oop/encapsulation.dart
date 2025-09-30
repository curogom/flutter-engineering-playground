class User {
  String _name; // private 속성

  User(this._name);

  String get name => _name; // name getter

  set name(String value) {
    // name setter
    if (value.isNotEmpty) {
      _name = value;
    }
  }
}

class Singleton {
  Singleton._(); // Private 생성자

  static final Singleton instance = Singleton._();

  factory Singleton() => instance;
}
