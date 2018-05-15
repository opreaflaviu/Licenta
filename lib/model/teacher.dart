import 'package:licenta/utils/constants.dart';

class Teacher {
  final int _teacherID;
  final String _name;
  final String _email;
  final String _web;
  final String _address;
  final String _photoURL;
  final String _department;

  const Teacher(this._teacherID, this._name, this._email, this._web, this._address, this._photoURL, this._department);


  int get teacherID => _teacherID;

  String get address => _address;

  String get web => _web;

  String get email => _email;

  String get name => _name;

  String get photoURL => _photoURL;

  String get department => _department;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map[Constants.teacherID] = this._teacherID;
    map[Constants.teacherName] = this._name;
    map[Constants.teacherEmail] = this._email;
    map[Constants.teacherWeb] = this._web;
    map[Constants.teacherAddress] = this._address;
    map[Constants.teacherPhotoURL] = this._photoURL;
    map[Constants.teacherDepartment] = this._department;
    return map;
  }

  Teacher.fromMap(Map map):
    this._teacherID = map[Constants.teacherID],
    this._name = map[Constants.teacherName],
    this._email = map[Constants.teacherEmail],
    this._web = map[Constants.teacherWeb],
    this._address = map[Constants.teacherAddress],
    this._photoURL= map[Constants.teacherPhotoURL],
    this._department = map[Constants.teacherDepartment];

  @override
  String toString() {
    return 'Teacher{_teacherID: $_teacherID, _name: $_name, _email: $_email, _web: $_web, _address: $_address, _photoURL: $_photoURL, _department: $_department}';
  }


}
