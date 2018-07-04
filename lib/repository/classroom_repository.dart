import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:licenta/database/database_helper.dart';
import 'package:licenta/model/classroom.dart';
import 'package:licenta/utils/constants.dart';
import 'package:licenta/utils/network_connection_utils.dart';

class ClassroomRepository {
  static var _classroomsList = new List<Classroom>();
  static DatabaseHelper _databaseHelper = new DatabaseHelper();

  Future<List<Classroom>> _getClassroomsFromDB() async {
    return await _databaseHelper.getClassrooms();
  }

  Future<List<Classroom>> _getClassroomsFromServer() async {

    var response = await http.get(
        Uri.encodeFull(
            Constants.apiRoot + "/classrooms"),
        headers: {"Accept": "appication/json"});

    List data = JSON.decode(response.body);

    var teachersList = new List<Classroom>();
    if (data.length != 0) {
      data.forEach((d) {
        Classroom classroom = new Classroom.fromMap(d);
        teachersList.add(classroom);
      });
    }
    return teachersList;
  }

  Future<List<Classroom>> loadClassroomList() async {
    if (_classroomsList.isEmpty) {
      if ((await new NetworkConnectionUtils().isConnection())) {
        _classroomsList = await _getClassroomsFromServer();
        await _databaseHelper.deleteAllClassrooms().then((onValue) { _databaseHelper.insertClassrooms(_classroomsList); });
      } else {
        _classroomsList = await _getClassroomsFromDB();
      }
    }

    return _classroomsList;
  }


}