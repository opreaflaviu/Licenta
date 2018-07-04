import 'dart:async';
import 'dart:convert';
import 'package:licenta/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../model/course.dart';
import 'package:licenta/database/database_helper.dart';
import 'package:licenta/utils/network_connection_utils.dart';



class CoursesRepository {
  static List<Course> _courseList = new List();
  static DatabaseHelper _databaseHelper = new DatabaseHelper();

  Future<List<Course>> _getAllCoursesFromDB() async {
    return await _databaseHelper.getCourses();
  }

  Future<List<Course>> _getAllCoursesFromServer() async {
    var response = await http.get(
        Uri.encodeFull(
            Constants.apiRoot + "/courses"),
        headers: {"Accept": "appication/json"});

    List data = JSON.decode(response.body);

    var coursesList = new List<Course>();
    if (data.length != 0) {
      data.forEach((d) {
        Course course = new Course.fromMap(d);
        coursesList.add(course);
      });
    }

    return coursesList;
  }



  Future<List<Course>> getCoursesByDay(String day) async {
    var courseListByDay = new List<Course>();
    if (_courseList.isEmpty) {
      if ((await new NetworkConnectionUtils().isConnection())) {
        _courseList = await _getAllCoursesFromServer();
        _courseList.sort((Course a, Course b) => a.courseHour.compareTo(b.courseHour));
        await _databaseHelper.deleteAllCourses().then((onValue) {_databaseHelper.insertCourses(_courseList);});
      } else {
          _courseList = await _getAllCoursesFromDB();
      }
    }

    _courseList.forEach((Course course) {
      if (course.courseDay.startsWith(day))
        courseListByDay.add(course);
    });

    return courseListByDay;
  }

}