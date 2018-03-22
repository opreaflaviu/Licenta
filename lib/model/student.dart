class Student {
  String _studentNumber;
  String _studentName;
  int _studentClass;
  String _studentPassword;

  Student( this._studentNumber, this._studentName, this._studentClass, this._studentPassword);

  String get studentNumber => this._studentNumber;
  set studentNumber(String studentNumber) {
    this._studentNumber = studentNumber;
  }

  String get studentName => this._studentName;
  set studentName(String studenName) {
    this._studentName = studentName;
  }

  int get studentClass => this._studentClass;
  set studentClass(int studentClass) {
    this._studentClass = studentClass;
  }

  String get studentPassword => this._studentPassword;
  set studentPassword(String studentPassword) {
    this._studentPassword = studentPassword;
  }

  Student.fromResponse(Map map){
    this._studentName = map["name"];
    this._studentNumber = map["student_number"];
    this._studentClass = map["class"];
    this._studentPassword = map["password"];
  }

  @override
  String toString() => _studentName + " " + _studentNumber + " " + _studentClass.toString() + " " + _studentPassword;
}