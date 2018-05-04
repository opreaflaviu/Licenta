import 'package:licenta/utils/constants.dart';

class Teacher {
  final int _teacherID;
  final String _name;
  final String _email;
  final String _web;
  final String _address;

  const Teacher(this._teacherID, this._name, this._email, this._web, this._address);

  int get courseID => _teacherID;

  String get address => _address;

  String get web => _web;

  String get email => _email;

  String get name => _name;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map[Constants.teacherID] = this._teacherID;
    map[Constants.teacherName] = this._name;
    map[Constants.teacherEmail] = this._email;
    map[Constants.teacherWeb] = this._web;
    map[Constants.teacherAddress] = this._address;
    return map;
  }

  Teacher.fromMap(Map map):
    this._teacherID = map[Constants.teacherID],
    this._name = map[Constants.teacherName],
    this._email = map[Constants.teacherEmail],
    this._web = map[Constants.teacherWeb],
    this._address = map[Constants.teacherAddress];

  @override
  String toString() {
    return 'Teacher{_teacherID: $_teacherID, _name: $_name, _email: $_email, _web: $_web, _address: $_address}';
  }


}
