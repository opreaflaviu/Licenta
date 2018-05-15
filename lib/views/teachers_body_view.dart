import 'package:licenta/model/teacher.dart';

abstract class TeachersBodyView {
  void onLoadTeachersComplete(List<Teacher> teachers);
  void onLoadTeachersError();
}