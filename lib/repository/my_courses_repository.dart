import 'dart:async';

import 'package:licenta/database/database_helper.dart';
import 'package:licenta/model/course.dart';
import 'package:licenta/exception/my_exception.dart';


class MyCoursesRepository {

  static List<Course> _courseList = new List();
  static DatabaseHelper _databaseHelper = new DatabaseHelper();

  Future<int> addMyCourse(Course myCourse) async {
    var response;
    try {
      response =  await _databaseHelper.insertMyCourse(myCourse);
    } catch (e){
      throw new MyException('Course is already added');
    }

    return response;
  }

  Future<int> deleteMyCourse(Course myCourse) async {
    var response;
    try {
      response =  await _databaseHelper.deleteMyCourse(myCourse);
    } catch (e){
      throw new MyException('Course does not exist');
    }

    return response;
  }

  Future<List<Course>> getCoursesByDay(day) async {
    _courseList = new List();
    List<Course> _courseListByDay = new List<Course>();

    _courseList = await _databaseHelper.getMyCourses();

    if(_courseList.isEmpty) {
      return [];
    }

    _courseList.sort((Course a, Course b) => a.courseHour.compareTo(b.courseHour));

    _courseList.forEach((Course course) {
      if (course.courseDay.startsWith(day))
        _courseListByDay.add(course);
    });


    return _courseListByDay;
  }



}