import 'dart:async';
import 'dart:convert';
import 'package:licenta/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../model/teacher.dart';
import 'package:licenta/database/database_helper.dart';
import 'package:licenta/utils/network_connection_utils.dart';



class TeachersRepository {
  static List<Teacher> _teachersList = new List();
  DatabaseHelper _databaseHelper = new DatabaseHelper();

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

    /*Teacher teacher1 = new Teacher(1, "Ion Ion", 'ion@email.com', 'https://www.cs.ubbcluj.ro/~gabis/', 'Str. Kogalniceanu Nr.1', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'cs');
    Teacher teacher2 = new Teacher(2, "Ion Andrei", 'andrei@email.com', 'https://www.cs.ubbcluj.ro/~gabis/', 'Str. Kogalniceanu Nr.1', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'cs');
    Teacher teacher3 = new Teacher(3, "Gheorghe Mihai", 'gheorghe.mihai@email.com', 'https://www.cs.ubbcluj.ro/~gabis/', 'Iugoslaviei Nr. 68', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'math');
    Teacher teacher4 = new Teacher(4, "Anca Anca", 'anca@email.com', 'https://www.cs.ubbcluj.ro/~gabis/', 'address4', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'csh');
    Teacher teacher5 = new Teacher(5, "Mihut Alex", 'alex_mihut@email.com', 'https://www.cs.ubbcluj.ro/~gabis/', 'address5', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'math');
    Teacher teacher6 = new Teacher(6, "Paul Paul", 'paulpaul@email.com', 'https://www.cs.ubbcluj.ro/~gabis/', 'address6', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'csh');

    return [teacher1, teacher2, teacher3, teacher4, teacher5, teacher6];*/
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