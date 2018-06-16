import 'package:licenta/utils/constants.dart';

class Classroom {
  final int _classroomID;
  final String _name;
  final String _building;
  final String _address;

  const Classroom(this._classroomID, this._name, this._building, this._address);

  int get classroomID => _classroomID;

  String get address => _address;

  String get building => _building;

  String get name => _name;

  Classroom.fromMap(Map map):
      _classroomID = int.parse(map[Constants.classroomID]),
      _name = map[Constants.classroomName],
      _building = map[Constants.classroomBuilding],
      _address = map[Constants.classroomAddress];

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map[Constants.classroomID] = this._classroomID;
    map[Constants.classroomName] = this._name;
    map[Constants.classroomBuilding] = this._building;
    map[Constants.classroomAddress] = this._address;
    return map;
  }

  @override
  String toString() {
    return 'Classroom{_name: $_name, _building: $_building, _address: $_address}';
  }


}