import 'package:licenta/model/classroom.dart';

abstract class ClassroomBodyView {
  void onLoadClassroomComplete(List<Classroom> classroomList);
  void onLoadClassroomError();
}

