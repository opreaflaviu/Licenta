
import 'package:licenta/exception/my_exception.dart';

import '../repository/courses_repository.dart';
import '../repository/my_courses_repository.dart';
import '../model/course.dart';
import '../views/courses_body_view.dart';

class CoursesBodyPresenter {
  CoursesBodyView _coursesBodyView;
  CoursesRepository _coursesRepository;
  MyCoursesRepository _myCoursesRepository;

  CoursesBodyPresenter(this._coursesBodyView){
    _coursesRepository = new CoursesRepository();
    _myCoursesRepository = new MyCoursesRepository();
  }

  void loadCoursesByDay(String day){
    assert(_coursesBodyView != null);

    _coursesRepository.getCoursesByDay(day)
      .then((courses) => _coursesBodyView.onLoadCoursesComplete(courses))
      .catchError((onError) {
        print(onError);
        _coursesBodyView.onLoadCoursesError();
     });
  }

  void addToMyCourses(Course myCourse){
    assert(_coursesBodyView != null);

    _myCoursesRepository.addMyCourse(myCourse)
      .then((value) => _coursesBodyView.onAddToMyCoursesComplete())
      .catchError((onError) {
        print(onError);
        _coursesBodyView.onAddToMyCoursesError(onError.toString());
    });
  }

  void deleteFromMyCourses(Course myCourse){
    assert(_coursesBodyView != null);

    _myCoursesRepository.deleteMyCourse(myCourse)
      .then((value) => _coursesBodyView.onDeleteFromMyCoursesComplete())
      .catchError((onError) {
        print(onError);
        _coursesBodyView.onDeleteFromMyCoursesError(onError.toString());
    });
  }


}