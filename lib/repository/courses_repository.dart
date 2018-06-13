import 'dart:async';
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
    Course c1 = new Course(1, 'Monday', '16:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c10 = new Course(10, 'Monday', '10:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c11 = new Course(11, 'Monday', '08:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c12 = new Course(12, 'Monday', '18:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c13 = new Course(13, 'Monday', '14:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c14 = new Course(14, 'Monday', '12:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c2 = new Course(2, 'Friday', '08:00', 'Weekly', '6/II', 'Course', 'OOP', 'Andrei Andrei');
    Course c3 = new Course(3, 'Thursday', '12:00', 'Even', 'L001', 'Laboratory', 'MAP', 'Ana Ana');
    Course c4 = new Course(4, 'Wednesday', '10:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c5 = new Course(5, 'Friday', '08:00', 'Weekly', '6/II', 'Course', 'OOP', 'Andrei Andrei');
    Course c6 = new Course(6, 'Tuesday', '12:00', 'Even', 'L001', 'Laboratory', 'MAP', 'Ana Ana');
    Course c7 = new Course(7, 'Monday', '10:00', 'Odd', 'L302', 'Seminar', 'LFTC', 'Ion Ion');
    Course c8 = new Course(8, 'Friday', '08:00', 'Weekly', '6/II', 'Course', 'OOP', 'Andrei Andrei');
    Course c9 = new Course(9, 'Thursday', '12:00', 'Even', 'L001', 'Laboratory', 'MAP', 'Ana Ana');
    return [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14];
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