import 'dart:async';
import 'dart:convert';
import 'package:licenta/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../model/teacher.dart';
import 'package:licenta/database/database_helper.dart';
import 'package:licenta/utils/network_connection_utils.dart';



class TeachersRepository {
  static List<Teacher> _teachersList = new List();
  static DatabaseHelper _databaseHelper = new DatabaseHelper();

  Future<List<Teacher>> _getAllTeachersFromDB() async {
    return await _databaseHelper.getTeachers();
  }

  Future<List<Teacher>> _getAllTeachersFromServer() async {
    var response = await http.get(
        Uri.encodeFull(
            Constants.apiRoot + "/teachers"),
        headers: {"Accept": "appication/json"});

    List data = JSON.decode(response.body);

    var teachersList = new List<Teacher>();
    if (data.length != 0) {
      data.forEach((d) {
        Teacher teacher = new Teacher.fromMap(d);
        teachersList.add(teacher);
      });
    }
    return teachersList;
  }

  Future<List<Teacher>> getTeachersByDepartment(String department) async {
    var teachersListByDepartment = new List<Teacher>();

    if (_teachersList.isEmpty) {
      if ((await new NetworkConnectionUtils().isConnection())) {
        _teachersList = await _getAllTeachersFromServer();
        await _databaseHelper.deleteAllTeachers().then((onValue) { _databaseHelper.insertTeachers(_teachersList); });
      } else {
        _teachersList = await _getAllTeachersFromDB();
      }
    }

    _teachersList.forEach((Teacher teacher) {
      if (teacher.department == department)
        teachersListByDepartment.add(teacher);
    });

    return teachersListByDepartment;
  }

}