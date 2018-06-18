import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:licenta/database/database_helper.dart';
import 'package:licenta/model/classroom.dart';
import 'package:licenta/utils/constants.dart';
import 'package:licenta/utils/network_connection_utils.dart';

class ClassroomRepository {

  static var _classroomsList = new List<Classroom>();
  DatabaseHelper _databaseHelper = new DatabaseHelper();

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

    /*Classroom c1 = new Classroom(1, "6/II", "Cladirea Centrala", "Str. Kogalniceanu, Nr. 1");
    Classroom c2 = new Classroom(2, "L302", "Campus", "Str. Theodor Mihali, Nr. 67");
    Classroom c3 = new Classroom(3, "e", "Cladirea Mathematica", "Str. Ploiesti, Nr1");
    Classroom c4 = new Classroom(4, "9/I", "Cladirea Centrala", "Str. Kogalniceanu, Nr1");
    Classroom c5 = new Classroom(5, "A312", "Cladirea Av. Iancu", "Str. A. Iancu, Nr1");
    Classroom c6 = new Classroom(6, "6/II", "Cladirea Centrala", "Str. Kogalniceanu, Nr1");
    Classroom c7 = new Classroom(7, "6/II", "Cladirea Centrala", "Str. Kogalniceanu, Nr1");
    Classroom c8 = new Classroom(8, "6/II", "Cladirea Centrala", "Str. Kogalniceanu, Nr1");
    Classroom c9 = new Classroom(9, "6/II", "Cladirea Centrala", "Str. Kogalniceanu, Nr1");

    return [c1, c2, c3, c4, c5, c6, c7, c8, c9];*/
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