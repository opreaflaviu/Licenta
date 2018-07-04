import 'package:flutter/material.dart';
import 'package:licenta/utils/colors_constant.dart';
import '../repository/student_repository.dart';
import '../model/student.dart';
import '../utils/shared_preferences_utils.dart';




class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => new LoginPageState();

}

class LoginPageState extends State<LoginPage> {

  static final TextEditingController _name = new TextEditingController();
  static final TextEditingController _number = new TextEditingController();
  static final TextEditingController _password = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  String _snackBarText = '';

  void _onChange(String snackBarText){
    setState((){
      _snackBarText = snackBarText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorsConstants.backgroundColor,
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text("Login", textAlign: TextAlign.center, style: new TextStyle(fontSize: 32.0, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: ColorsConstants.primaryColor,
        elevation: 0.0,
        automaticallyImplyLeading: false
      ),
      body: new Center(
          
          child: new Container(
            margin: new EdgeInsets.only(right: 32.0, left: 32.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                new TextField(
                  decoration: new InputDecoration(labelText: 'Name', hintText: "ex: Popescu Ion", contentPadding: new EdgeInsets.only(top: 16.0), labelStyle: new TextStyle(fontSize: 16.0)),
                  style: new TextStyle(fontSize: 20.0, color: Colors.black),
                  controller: _name                
                ),

                new TextField(
                  decoration: new InputDecoration(labelText: 'Number', contentPadding: new EdgeInsets.only(top: 16.0), labelStyle: new TextStyle(fontSize: 16.0)),
                  style: new TextStyle(fontSize: 20.0, color: Colors.black),
                  controller: _number
                ),

                new TextField(
                  decoration: new InputDecoration(labelText: 'Password', contentPadding: new EdgeInsets.only(top: 16.0), labelStyle: new TextStyle(fontSize: 16.0)), 
                  style: new TextStyle(fontSize: 20.0, color: Colors.black),
                  obscureText: true,
                  controller: _password
                ),

                new Container(
                  padding: new EdgeInsets.only(top: 16.0),
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      padding: new EdgeInsets.only(left: 32.0, right: 32.0),
                      child: new Text("Back", textScaleFactor: 1.2),
                      onPressed: (() =>_onBackClick(context)),
                    ),

                    new FlatButton(
                      padding: new EdgeInsets.only(left: 32.0, right: 32.0),
                      child: new Text("Login", textScaleFactor: 1.2),
                      onPressed: _onLoginClick,
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  void _clearTextFields(){
    _name.clear();
    _number.clear();
    _password.clear();
  }

  void _onBackClick(BuildContext context){
    _clearTextFields();
    Navigator.of(context).pop(true);
  }  

  void _onLoginClick(){   
    var studentResponse = new StudentRepository().getStudent(_number.text);
    studentResponse.then((student) {
      _studentIsValid(student) ? _validStudent(student) : _invalidStudent();
      });
  }

  void _invalidStudent(){
    _onChange("Wrong Credentials"); 
    _showSnackBar();
    _clearTextFields();
  }

  void _validStudent(Student student){
    _saveInSharedPrefs(student);
    Navigator.of(context).pushNamedAndRemoveUntil('main_page', (Route<dynamic> route) =>false);
  }

  bool _studentIsValid(Student student) =>
    student.studentName == _name.text && student.studentPassword == _password.text ? true : false;

  void _showSnackBar(){
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Text(_snackBarText)
    ));
  }

  void _saveInSharedPrefs(Student student) async {
    SharedPreferencesUtils sharedPreferencesUtils = new SharedPreferencesUtils();
    sharedPreferencesUtils.saveStudent(student);
  }

}
