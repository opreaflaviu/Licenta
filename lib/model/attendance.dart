import 'package:licenta/utils/constants.dart';

class Attendance {
  final String _courseName;
  final String _courseType;
  final String _attendanceDates;

  Attendance(this._courseName, this._courseType, this._attendanceDates);


  String get courseName => _courseName;

  String get courseType => _courseType;

  String get attendanceDates => _attendanceDates;


  Attendance.fromMap(Map map):
    _courseName = map[Constants.courseName],
    _courseType = map[Constants.courseType],
    _attendanceDates = map["attendanceDate"];

  @override
  String toString() {
    return 'Attendance{_courseName: $_courseName, _courseType: $_courseType, _attendanceDates: $_attendanceDates}';
  }


}