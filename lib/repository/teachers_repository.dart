import 'dart:async';
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
    Teacher teacher1 = new Teacher(1, "Ion Ion", 'ion@email.com', 'www.ion.ro', 'address1', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'cs');
    Teacher teacher2 = new Teacher(2, "Ion Andrei", 'andrei@email.com', 'www.andrei.ro', 'address2', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'cs');
    Teacher teacher3 = new Teacher(3, "Gheorghe Mihai", 'gheorghe.mihai@email.com', 'www.gheorghe.ro', 'address3', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'math');
    Teacher teacher4 = new Teacher(4, "Anca Anca", 'anca@email.com', 'www.ancaanca.ro', 'address4', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'csh');
    Teacher teacher5 = new Teacher(5, "Mihut Alex", 'alex_mihut@email.com', 'www.mihut.ro', 'address5', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'math');
    Teacher teacher6 = new Teacher(6, "Paul Paul", 'paulpaul@email.com', 'www.paul.ro', 'address6', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ash_Tree_-_geograph.org.uk_-_590710.jpg/450px-Ash_Tree_-_geograph.org.uk_-_590710.jpg', 'csh');

    return [teacher1, teacher2, teacher3, teacher4, teacher5, teacher6];
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