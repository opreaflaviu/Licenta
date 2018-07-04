import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:licenta/utils/constants.dart';
import 'package:quiver/collection.dart';
import 'package:licenta/model/attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceRepository {

  static Multimap<String, String> _attendanceList;

  AttendanceRepository(){
    _attendanceList = new Multimap();
  }

  Future<List<Attendance>> _getAttendanceFromServer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String studentName = sharedPreferences.getString(Constants.studentNumber);

    var response = await http.get(
        Uri.encodeFull(
            Constants.apiRoot + "/attendance/'$studentName'"),
        headers: {"Accept": "appication/json"});

    List data = JSON.decode(response.body);

    var attendanceList = new List<Attendance>();
    if (data.length != 0) {
      data.forEach((d) {
        attendanceList.add(new Attendance.fromMap(d));
      });
    }

    return attendanceList;
  }

  List<String> _getDatesByCourseName(String courseName, List<Attendance> attendanceListFromServer) {
    List courseDatesList = new List<String>();

    for(var a in attendanceListFromServer) {
      if (a.courseName.compareTo(courseName) == 0) {
        courseDatesList.add(a.attendanceDates+ "     " +a.courseType);
      }
    }
    return courseDatesList;
  }

  Future<Multimap<String, String>> getAttendanceList() async {
    List<Attendance> attendanceListFromServer = await _getAttendanceFromServer();

    for(var a in attendanceListFromServer) {
      String courseName = a.courseName;
      if (!_attendanceList.containsKey(courseName)) {
        _attendanceList.addValues(courseName, Iterable.castFrom(_getDatesByCourseName(courseName, attendanceListFromServer)));
      }
    }

    return _attendanceList;
  }
}