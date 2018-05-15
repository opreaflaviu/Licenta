abstract class Constants {
  
  //static const String apiRoot = "http://192.168.100.11/ServerLicenta2/public/api/students";
  static const String apiRoot = "http://172.30.116.22/ServerLicenta2/public/api/students";
  static const String studentNumber = "student_number";
  static const String studentName = "name";
  static const String studentClass = "class";
  static const String studentPassword = "password";

  static const String monday = "Mon";
  static const String tuesday = "Tue";
  static const String wednesday = "Wed";
  static const String thursday = "Thu";
  static const String friday = "Fri";


  static const String createCoursesTableQuery = "CREATE TABLE Courses(courseID INTEGER PRIMARY KEY AUTOINCREMENT, courseDay TEXT, courseHour TEXT, courseFrequency TEXT, courseRoom TEXT, courseType TEXT, courseName TEXT, courseTeacher TEXT)";
  static const String deleteAllCoursesQuery = "DELETE FROM Courses";

  static const String createMyCoursesTableQuery = "CREATE TABLE MyCourses(courseID INTEGER PRIMARY KEY AUTOINCREMENT, courseDay TEXT, courseHour TEXT, courseFrequency TEXT, courseRoom TEXT, courseType TEXT, courseName TEXT, courseTeacher TEXT)";

  static const String createUserTableQuery = "CREATE TABLE User(studentNumber TEXT, studentName TEXT, studentClass INTEGER)";

  static const String createTeachersTableQuery = "CREATE TABLE Teachers(teacherID INTEGER PRIMARY KEY AUTOINCREMENT, teacherName TEXT, teacherEmail TEXT, teacherWeb TEXT, teacherAddress TEXT, teacherPhotoURL TEXT, teacherDepartment)";
  static const String deleteAllTeachersQuery = "DELETE FROM Teachers";


  static const String databaseName = "maindatabase.db";
  static const String coursesTableName = "Courses";
  static const String myCoursesTableName = "MyCourses";
  static const String teachersTableName = "Teachers";
  static const String userTableName = "User";

  static const String courseID = "courseID";
  static const String courseDay = "courseDay";
  static const String courseHour = "courseHour";
  static const String courseFrequency = "courseFrequency";
  static const String courseRoom = "courseRoom";
  static const String courseType = "courseType";
  static const String courseName = "courseName";
  static const String courseTeacher = "courseTeacher";

  static const String teacherID = "teacherID";
  static const String teacherName = "teacherName";
  static const String teacherEmail = "teacherEmail";
  static const String teacherWeb = "teacherWeb";
  static const String teacherAddress = "teacherAddress";
  static const String teacherPhotoURL = "teacherPhotoURL";
  static const String teacherDepartment = "teacherDepartment";

  static const String CS = "cs";
  static const String CSH = "csh";
  static const String Math = "math";






}