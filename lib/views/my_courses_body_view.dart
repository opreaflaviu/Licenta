import 'package:licenta/model/course.dart';

abstract class MyCoursesBodyView {
  void onLoadCoursesComplete(List<Course> myCourses);
  void onLoadCoursesError();

  void onDeleteFromMyCoursesComplete();
  void onDeleteFromMyCoursesError();

}