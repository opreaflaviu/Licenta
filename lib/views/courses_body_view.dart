import 'package:licenta/model/course.dart';

abstract class CoursesBodyView {
  void onLoadCoursesComplete(List<Course> courses);
  void onLoadCoursesError();

  void onAddToMyCoursesComplete();
  void onAddToMyCoursesError(String errorMessage);

  void onDeleteFromMyCoursesComplete();
  void onDeleteFromMyCoursesError(String errorMessage);
}