import 'package:licenta/repository/classroom_repository.dart';
import 'package:licenta/views/classroom_body_view.dart';

class ClassroomPresenter {
  ClassroomRepository _classroomRepository;
  ClassroomBodyView _classroomBodyView;

  ClassroomPresenter(this._classroomBodyView) {
    _classroomRepository = new ClassroomRepository();
  }

  void loadClassroomList() async {
    _classroomRepository.loadClassroomList()
        .then((classroomList) => _classroomBodyView.onLoadClassroomComplete(classroomList))
        .catchError(() => _classroomBodyView.onLoadClassroomError());
  }
}