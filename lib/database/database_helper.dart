import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:licenta/utils/constants.dart';
import 'package:licenta/model/course.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  static Database _database;

  Future<Database> get database async {
    if (_database != null){
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, Constants.databaseName);
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database database, int version) async {
    await database.execute(Constants.createCoursesTableQuery);
    await database.execute(Constants.createMyCoursesTableQuery);
    print('Table was created');
  }


  //Course
  Future<int> _insertCourse(Course course) async {
    var db = await database;
    return await db.insert(Constants.coursesTableName, course.toMap());
  }

  Future<int> insertCourses(List<Course> courses) async {
    int res;
    courses.forEach((course) async {
      res = await _insertCourse(course);
    });
    return res;
  }

  Future<int> deleteCourse(Course course) async {
    var db = await database;
    return await db.delete(Constants.coursesTableName,
        where: Constants.courseDay + " = ? AND " + Constants.courseHour + " = ? AND " + Constants.courseName + " = ?",
        whereArgs: [course.courseDay, course.courseHour, course.courseName]);
  }

  Future<dynamic> deleteAllCourses() async {
    var db = await database;
    return await db.execute(Constants.deleteAllCoursesQuery);
  }

  Future<List<Course>> getCourses() async {
    var db = await database;
    var coursesList = new List<Course>();

    List<Map> maps = await db.query(Constants.coursesTableName,
      columns: ['courseId', 'courseDay', 'courseHour', 'courseFrequency', 'courseRoom', 'courseType', 'courseName', 'courseTeacher']);
    if (maps.length > 0){
      maps.forEach((map) {
        coursesList.add(new Course.fromMap(map));
      });
    }
    return coursesList;
  }


  //MyCourse
  Future<int> insertMyCourse(Course course) async {
    var db = await database;
    return await db.insert(Constants.myCoursesTableName, course.toMap());
  }

  Future<int> deleteMyCourse(Course course) async {
    var db = await database;
    return await db.delete(Constants.myCoursesTableName,
        where: Constants.courseDay + " = ? AND " + Constants.courseHour + " = ? AND " + Constants.courseName + " = ?",
        whereArgs: [course.courseDay, course.courseHour, course.courseName]);
  }

  Future<List<Course>> getMyCourses() async {
    var db = await database;
    var myCoursesList = new List<Course>();

    List<Map> maps = await db.query(Constants.myCoursesTableName,
        columns: ['courseId', 'courseDay', 'courseHour', 'courseFrequency', 'courseRoom', 'courseType', 'courseName', 'courseTeacher']);
    if (maps.length > 0){
      maps.forEach((map) {
        myCoursesList.add(new Course.fromMap(map));
      });
    }
    return myCoursesList;
  }


}