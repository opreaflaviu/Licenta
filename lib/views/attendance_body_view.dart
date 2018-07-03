
import 'package:quiver/collection.dart';

abstract class AttendanceBodyView {
  void onLoadAttendanceComplete(Multimap<String, String> attendanceList);
  void onLoadAttendanceError();
}