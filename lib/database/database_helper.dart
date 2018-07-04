import 'package:licenta/database/database_contract.dart';
import 'package:licenta/model/classroom.dart';
import 'package:licenta/model/news.dart';
import 'package:licenta/model/teacher.dart';
import 'package:licenta/utils/constants.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:licenta/model/course.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DatabaseContract.databaseName);
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }



  void _onCreate(Database db, int version) async {
    await db.execute(DatabaseContract.createClassroomTableQuery);
    await db.execute(DatabaseContract.createSavedNewsTableQuery);
    await db.execute(DatabaseContract.createCoursesTableQuery);
    await db.execute(DatabaseContract.createMyCoursesTableQuery);
    await db.execute(DatabaseContract.createTeachersTableQuery);
    print('Table was created');
  }

  //Course
  Future<int> _insertCourse(Course course) async {
    var database = await db;
    return await database.rawInsert(
        "INSERT INTO ${DatabaseContract.coursesTableName}(${Constants.courseID}, ${Constants.courseDay}, ${Constants.courseHour}, ${Constants.courseFrequency},${Constants.courseRoom}, ${Constants.courseType}, ${Constants.courseName}, ${Constants.courseTeacher}) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
    [course.courseID, course.courseDay, course.courseHour, course.courseFrequency, course.courseRoom, course.courseType, course.courseName, course.courseTeacher]);
    //return await database.insert(DatabaseContract.coursesTableName, course.toMap());
  }

  Future<int> insertCourses(List<Course> courses) async {
    int res;
    courses.forEach((course) async {
      res = await _insertCourse(course);
    });
    return res;
  }

  Future<int> deleteCourse(Course course) async {
    var database = await db;
    return await database.delete(DatabaseContract.coursesTableName,
        where: Constants.courseDay + " = ? AND " + Constants.courseHour + " = ? AND " + Constants.courseName + " = ?",
        whereArgs: [course.courseDay, course.courseHour, course.courseName]);
  }

  Future<int> deleteAllCourses() async {
    var database = await db;
    int res = await database.delete(DatabaseContract.coursesTableName);
    //int res = await database.execute(DatabaseContract.deleteAllCoursesQuery);
    return res;
  }

  Future<List<Course>> getCourses() async {
    var database = await db;
    var coursesList = new List<Course>();

    List<Map> maps = await database.query(DatabaseContract.coursesTableName,
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
    var database = await db;
    print('MyCourse Inser   ${course.courseName}');
    return await database.rawInsert(
        "INSERT INTO ${DatabaseContract.myCoursesTableName}(${Constants.courseID}, ${Constants.courseDay}, ${Constants.courseHour}, ${Constants.courseFrequency},${Constants.courseRoom}, ${Constants.courseType}, ${Constants.courseName}, ${Constants.courseTeacher}) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [course.courseID, course.courseDay, course.courseHour, course.courseFrequency, course.courseRoom, course.courseType, course.courseName, course.courseTeacher]);

    //return await database.insert(DatabaseContract.myCoursesTableName, course.toMap());
  }

  Future<int> deleteMyCourse(Course course) async {
    var database = await db;
    return await database.delete(DatabaseContract.myCoursesTableName,
        where: Constants.courseDay + " = ? AND " + Constants.courseHour + " = ? AND " + Constants.courseName + " = ?",
        whereArgs: [course.courseDay, course.courseHour, course.courseName]);
  }

  Future<List<Course>> getMyCourses() async {
    var database = await db;
    var myCoursesList = new List<Course>();

    List<Map> maps = await database.query(DatabaseContract.myCoursesTableName,
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
    var database = await db;
    return await database.rawInsert(
        "INSERT INTO ${DatabaseContract.teachersTableName}(${Constants.teacherID}, ${Constants.teacherName}, ${Constants.teacherEmail}, ${Constants.teacherWeb},${Constants.teacherAddress}, ${Constants.teacherPhotoURL}, ${Constants.teacherDepartment}) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [teacher.teacherID, teacher.name, teacher.email, teacher.web, teacher.address, teacher.photoURL, teacher.department]);
    //return await database.insert(DatabaseContract.teachersTableName, teacher.toMap());
  }

  Future<int> insertTeachers(List<Teacher> teachersList) async {
    int res;
    teachersList.forEach((teacher) async {
      res = await _insertTeacher(teacher);
      print("REssssss  $res");
    });

    return res;
  }

  Future<List<Teacher>> getTeachers() async {
    var database = await db;
    var teachersList = new List<Teacher>();

    List<Map> maps = await database.query(DatabaseContract.teachersTableName,
      columns: [Constants.teacherID, Constants.teacherName, Constants.teacherEmail, Constants.teacherWeb, Constants.teacherAddress, Constants.teacherPhotoURL]);

    if (maps.length > 0) {
      maps.forEach((map) {
        teachersList.add(new Teacher.fromMap(map));
      });
    }
    return teachersList;
  }

  Future<int> deleteAllTeachers() async {
    var database = await db;
    int res = await database.delete(DatabaseContract.teachersTableName);
    //int res = await database.execute(DatabaseContract.deleteAllTeachersQuery);
    return res;
  }

  //News
  Future<List<News>> getSavedNews() async {
    var database = await db;
    var savedNewsList = new List<News>();

    List<Map> maps = await database.query(DatabaseContract.savedNewsTableName,
      columns: [Constants.newsTitle, Constants.newsLink]);

    if (maps.length > 0) {
      maps.forEach((map) {
        savedNewsList.add(new News.fromMap(map));
      });
    }

    return savedNewsList;
  }

  Future<int> insertNews(News news) async {
    var database = await db;
    return await database.insert(DatabaseContract.savedNewsTableName, news.toMap());
  }

  Future<int> deleteSavedNews(News news) async {
    var database = await db;
    print(news.toString());
    return await database.delete(DatabaseContract.savedNewsTableName,
        where: Constants.newsTitle + " = ? AND " + Constants.newsLink + " = ?",
        whereArgs: [news.title, news.link]);
  }


  //Classroom
  Future<int> _insertClassroom(Classroom classroom) async {
    var database = await db;
    return await database.insert(DatabaseContract.classroomTableName, classroom.toMap());
  }

  Future<int> insertClassrooms(List<Classroom> classroomsList) async {
    int res;
    classroomsList.forEach((classroom) async {
      res = await _insertClassroom(classroom);
    });

    return res;
  }

  Future<List<Classroom>> getClassrooms() async {
    var database = await db;
    var classroomList = new List<Classroom>();

    List<Map> maps = await database.query(DatabaseContract.classroomTableName,
        columns: [Constants.classroomName, Constants.classroomBuilding, Constants.classroomAddress]);

    if (maps.length > 0) {
      maps.forEach((map) {
        classroomList.add(new Classroom.fromMap(map));
      });
    }

    return classroomList;
  }

  Future<int> deleteAllClassrooms() async {
    var database = await db;
    int res = await database.execute(DatabaseContract.deleteAllClassroomsQuery);
    return res;
  }
}