import 'package:licenta/database/database_contract.dart';
import 'package:licenta/model/news.dart';
import 'package:licenta/model/teacher.dart';
import 'package:licenta/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
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
    String path = join(documentDirectory.path, DatabaseContract.databaseName);
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database database, int version) async {
    await database.execute(DatabaseContract.createSavedNewsTableQuery);
    await database.execute(DatabaseContract.createCoursesTableQuery);
    await database.execute(DatabaseContract.createMyCoursesTableQuery);
    await database.execute(DatabaseContract.createTeachersTableQuery);
    print('Table was created');
  }

  closeDatabase() {
    _database.close();
  }

  //Course
  Future<int> _insertCourse(Course course) async {
    var db = await database;
    return await db.insert(DatabaseContract.coursesTableName, course.toMap());
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
    return await db.delete(DatabaseContract.coursesTableName,
        where: Constants.courseDay + " = ? AND " + Constants.courseHour + " = ? AND " + Constants.courseName + " = ?",
        whereArgs: [course.courseDay, course.courseHour, course.courseName]);
  }

  Future<dynamic> deleteAllCourses() async {
    var db = await database;
    return await db.execute(DatabaseContract.deleteAllCoursesQuery);
  }

  Future<List<Course>> getCourses() async {
    var db = await database;
    var coursesList = new List<Course>();

    List<Map> maps = await db.query(DatabaseContract.coursesTableName,
      columns: [Constants.courseID, Constants.courseDay, Constants.courseHour, Constants.courseFrequency, Constants.courseRoom, Constants.courseType, Constants.courseName, Constants.courseTeacher]);
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
    return await db.insert(DatabaseContract.myCoursesTableName, course.toMap());
  }

  Future<int> deleteMyCourse(Course course) async {
    var db = await database;
    return await db.delete(DatabaseContract.myCoursesTableName,
        where: Constants.courseDay + " = ? AND " + Constants.courseHour + " = ? AND " + Constants.courseName + " = ?",
        whereArgs: [course.courseDay, course.courseHour, course.courseName]);
  }

  Future<List<Course>> getMyCourses() async {
    var db = await database;
    var myCoursesList = new List<Course>();

    List<Map> maps = await db.query(DatabaseContract.myCoursesTableName,
        columns: [Constants.courseID, Constants.courseDay, Constants.courseHour, Constants.courseFrequency, Constants.courseRoom, Constants.courseType, Constants.courseName, Constants.courseTeacher]);

    if (maps.length > 0){
      maps.forEach((map) {
        myCoursesList.add(new Course.fromMap(map));
      });
    }
    return myCoursesList;
  }


  //Teachers
  Future<int> _insertTeacher(Teacher teacher) async {
    var db = await database;
    return await db.insert(DatabaseContract.teachersTableName, teacher.toMap());
  }

  Future<int> insertTeachers(List<Teacher> teachersList) async {
    int res;
    teachersList.forEach((teacher) async {
      res = await _insertTeacher(teacher);
    });

    return res;
  }

  Future<List<Teacher>> getTeachers() async {
    var db = await database;
    var teachersList = new List<Teacher>();

    List<Map> maps = await db.query(DatabaseContract.teachersTableName,
      columns: [Constants.teacherID, Constants.teacherName, Constants.teacherEmail, Constants.teacherWeb, Constants.teacherAddress, Constants.teacherPhotoURL]);

    if (maps.length > 0) {
      maps.forEach((map) {
        teachersList.add(new Teacher.fromMap(map));
      });
    }

    return teachersList;
  }

  Future<int> deleteAllTeachers() async {
    var db = await database;
    return await db.execute(DatabaseContract.deleteAllTeachersQuery);
  }

  //News
  Future<List<News>> getSavedNews() async {
    var db = await database;
    var savedNewsList = new List<News>();

    List<Map> maps = await db.query(DatabaseContract.savedNewsTableName,
      columns: [Constants.newsTitle, Constants.newsLink]);

    if (maps.length > 0) {
      maps.forEach((map) {
        savedNewsList.add(new News.fromMap(map));
      });
    }

    return savedNewsList;
  }

  Future<int> insertNews(News news) async {
    var db = await database;
    return await db.insert(DatabaseContract.savedNewsTableName, news.toMap());
  }

  Future<int> deleteSavedNews(News news) async {
    var db = await database;
    print(news.toString());
    return await db.delete(DatabaseContract.savedNewsTableName,
        where: Constants.newsTitle + " = ? AND " + Constants.newsLink + " = ?",
        whereArgs: [news.title, news.link]);
  }
}