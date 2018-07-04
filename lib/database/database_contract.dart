import 'package:licenta/utils/constants.dart';

abstract class DatabaseContract {
  static const String createCoursesTableQuery = "CREATE TABLE Courses(courseID INTEGER PRIMARY KEY , courseDay TEXT, courseHour TEXT, courseFrequency TEXT, courseRoom TEXT, courseType TEXT, courseName TEXT, courseTeacher TEXT)";
  static const String deleteAllCoursesQuery = "DELETE FROM Courses";

  static const String createMyCoursesTableQuery = "CREATE TABLE MyCourses(courseID INTEGER PRIMARY KEY, courseDay TEXT, courseHour TEXT, courseFrequency TEXT, courseRoom TEXT, courseType TEXT, courseName TEXT, courseTeacher TEXT)";

  static const String createUserTableQuery = "CREATE TABLE User(studentNumber TEXT, studentName TEXT, studentClass INTEGER)";

  static const String createTeachersTableQuery = "CREATE TABLE Teachers(teacherID INTEGER PRIMARY KEY, teacherName TEXT, teacherEmail TEXT, teacherWeb TEXT, teacherAddress TEXT, teacherPhotoURL TEXT, teacherDepartment TEXT)";
  static const String deleteAllTeachersQuery = "DELETE FROM Teachers";

  static const String createSavedNewsTableQuery = "CREATE TABLE SavedNews(title TEXT PRIMARY KEY, link TEXT)";

  static const String createClassroomTableQuery = "CREATE TABLE Classrooms(classroomName TEXT PRIMARY KEY, classroomBuilding TEXT, classroomAddress TEXT)";
  static const String deleteAllClassroomsQuery = "DELETE FROM Classrooms";

  static const String databaseName = "appdatabase.db";
  static const String coursesTableName = "Courses";
  static const String myCoursesTableName = "MyCourses";
  static const String teachersTableName = "Teachers";
  static const String userTableName = "User";
  static const String savedNewsTableName = "SavedNews";
  static const String classroomTableName = "Classrooms";
}