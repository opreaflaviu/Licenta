import '../repository/my_courses_repository.dart';
import '../model/course.dart';
import '../views/my_courses_body_view.dart';

class MyCoursesBodyPresenter {

  MyCoursesRepository _myCoursesRepository;
  MyCoursesBodyView _myCoursesBodyView;

  MyCoursesBodyPresenter(this._myCoursesBodyView){
    _myCoursesRepository = new MyCoursesRepository();
  }

  void loadMyCoursesByDay(String day){
    assert(_myCoursesBodyView != null);

    _myCoursesRepository.getCoursesByDay(day)
      .then((myCourses) => _myCoursesBodyView.onLoadCoursesComplete(myCourses))
      .catchError((onError){
        print(onError);
        _myCoursesBodyView.onLoadCoursesError();
    });
  }

  void deleteFromMyCourses(Course myCourse){
    assert(_myCoursesBodyView != null);

    _myCoursesRepository.deleteMyCourse(myCourse)
      .then((value) => _myCoursesBodyView.onDeleteFromMyCoursesComplete())
      .catchError((onError) {
        print(onError);
        _myCoursesBodyView.onDeleteFromMyCoursesError();
    });
  }


}