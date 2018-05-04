import 'package:licenta/utils/constants.dart';

class Course {
  final int _courseID;
  final String _courseDay;
  final String _courseHour;
  final String _courseFrequency;
  final String _courseRoom;
  final String _courseType;
  final String _courseName;
  final String _courseTeacher;

  const Course(this._courseID, this._courseDay, this._courseHour, this._courseFrequency,
      this._courseRoom, this._courseType, this._courseName,
      this._courseTeacher);


  int get courseID => this._courseID;

  String get courseTeacher => this._courseTeacher;

  String get courseName => this._courseName;

  String get courseType => this._courseType;

  String get courseRoom => this._courseRoom;

  String get courseFrequency => this._courseFrequency;

  String get courseHour => this._courseHour;

  String get courseDay => this._courseDay;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map[Constants.courseID] = this._courseID;
    map[Constants.courseDay] = this._courseDay;
    map[Constants.courseHour] = this._courseHour;
    map[Constants.courseFrequency] = this._courseFrequency;
    map[Constants.courseRoom] = this._courseRoom;
    map[Constants.courseType] = this._courseType;
    map[Constants.courseName] = this._courseName;
    map[Constants.courseTeacher] = this._courseTeacher;
    return map;
  }

  Course.fromMap(Map map):
    this._courseID = map[Constants.courseID],
    this._courseDay =  map[Constants.courseDay],
    this._courseHour = map[Constants.courseHour],
    this._courseFrequency = map[Constants.courseFrequency],
    this._courseRoom = map[Constants.courseRoom],
    this._courseType = map[Constants.courseType],
    this._courseName = map[Constants.courseName],
    this._courseTeacher = map[Constants.courseTeacher];


  @override
  String toString() {
    return 'Course{_courseID: $_courseID, _courseDay: $_courseDay, _courseHour: $_courseHour, _courseFrequency: $_courseFrequency, _courseRoom: $_courseRoom, _courseType: $_courseType, _courseName: $_courseName, _courseTeacher: $_courseTeacher}';
  }
}


