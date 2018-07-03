import 'package:licenta/repository/attendance_repository.dart';
import 'package:licenta/views/attendance_body_view.dart';

class AttendancePresenter {
  AttendanceBodyView _attendanceBodyView;
  AttendanceRepository _attendanceRepository;

  AttendancePresenter(this._attendanceBodyView){
    _attendanceRepository = new AttendanceRepository();
  }

  void getAttendanceList(){
    _attendanceRepository.getAttendanceList()
        .then((attendanceList) => _attendanceBodyView.onLoadAttendanceComplete(attendanceList))
        .catchError(() => _attendanceBodyView.onLoadAttendanceError());
  }

}