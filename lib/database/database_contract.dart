import 'package:licenta/utils/constants.dart';

abstract class DatabaseContract {
  static const String createCoursesTableQuery = "CREATE TABLE $coursesTableName(courseID INTEGER PRIMARY KEY , courseDay TEXT, courseHour TEXT, courseFrequency TEXT, courseRoom TEXT, courseType TEXT, courseName TEXT, courseTeacher TEXT)";
  static const String deleteAllCoursesQuery = "DELETE FROM $coursesTableName";

  static const String createMyCoursesTableQuery = "CREATE TABLE $myCoursesTableName(courseID INTEGER PRIMARY KEY AUTOINCREMENT, courseDay TEXT, courseHour TEXT, courseFrequency TEXT, courseRoom TEXT, courseType TEXT, courseName TEXT, courseTeacher TEXT)";

  static const String createUserTableQuery = "CREATE TABLE $userTableName(studentNumber TEXT, studentName TEXT, studentClass INTEGER)";

  static const String createTeachersTableQuery = "CREATE TABLE $teachersTableName(teacherID INTEGER PRIMARY KEY AUTOINCREMENT, teacherName TEXT, teacherEmail TEXT, teacherWeb TEXT, teacherAddress TEXT, teacherPhotoURL TEXT, teacherDepartment)";
  static const String deleteAllTeachersQuery = "DELETE FROM $teachersTableName";

  static const String createSavedNewsTableQuery = "CREATE TABLE $savedNewsTableName(${Constants.newsTitle} TEXT PRIMARY KEY, ${Constants.newsLink} TEXT)";

  static const String createClassroomTableQuery = "CREATE TABLE $classroomTableName(${Constants.classroomID} INTEGER PRIMARY KEY, ${Constants.classroomName} TEXT, ${Constants.classroomBuilding} TEXT, ${Constants.classroomAddress} TEXT)";
  static const String deleteAllClassroomsQuery = "DELETE FROM $classroomTableName";

  static const String databaseName = "maindatabase.db";
  static const String coursesTableName = "Courses";
  static const String myCoursesTableName = "MyCourses";
  static const String teachersTableName = "Teachers";
  static const String userTableName = "User";
  static const String savedNewsTableName = "SavedNews";
  static const String classroomTableName = "Classrooms";
}