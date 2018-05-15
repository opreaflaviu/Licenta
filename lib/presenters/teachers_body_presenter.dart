import 'package:licenta/repository/teachers_repository.dart';
import 'package:licenta/views/teachers_body_view.dart';

class TeachersBodyPresenter {
  TeachersRepository _teachersRepository;
  TeachersBodyView _teachersBodyView;

  TeachersBodyPresenter(this._teachersBodyView){
    _teachersRepository = new TeachersRepository();
  }

  void loadTeachersByDepartment(String department) {
    assert (_teachersBodyView != null);

    _teachersRepository.getTeachersByDepartment(department)
      .then((teachers) => _teachersBodyView.onLoadTeachersComplete(teachers))
      .catchError((onError) {
        print(onError);
        _teachersBodyView.onLoadTeachersError();
    });
  }

}