
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../model/student.dart';
import '../model/server_response.dart';
import '../utils/constants.dart';



class StudentRepository {

  Future<Student> getStudent(String studentName) async {
    var response = await http.get(
        Uri.encodeFull(
          Constants.apiRoot + "/students/'$studentName'"),
          headers: {"Accept": "appication/json"});

    List data = JSON.decode(response.body);
    if (data.length != 0){
      Map map = data.elementAt(0);
      String studentNumberResponse = map[Constants.studentNumber];
      String studentNameResponse = map[Constants.studentName];
      print(map.toString());
      int studentClassResponse = int.parse(map[Constants.studentClass]);
      String studentPasswordResponse = map[Constants.studentPassword];
      return new Student(studentNumberResponse, studentNameResponse, studentClassResponse, studentPasswordResponse);
    }
    return new Student('', '', 0, '');
  }

  Future<ServerResponse> postStudent(Student student) async{
    final studentName = student.studentName;
    final studentNumber = student.studentNumber;
    final studentClass = student.studentClass;
    final studentPassword = student.studentPassword;

    var response = await http.post(
        Uri.encodeFull(
            Constants.apiRoot + "/students/add"),
        headers: {
          "Accept": "appication/json"
        },
        body: {
          Constants.studentNumber : "$studentNumber",
          Constants.studentName : "$studentName",
          Constants.studentClass : "$studentClass",
          Constants.studentPassword : "$studentPassword"
        });
    Map data = JSON.decode(response.body); 
    return new ServerResponse.fromMap(data);
  }
}
