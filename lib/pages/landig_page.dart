import 'package:flutter/material.dart';
import '../pages/main_page.dart';
import '../utils/constants.dart';
import '../model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  var studentName = '';
  var studentNumber = '';
  var studentClass = -1;

  

  @override
  Widget build(BuildContext context) {
    _getFromSharedPrefs();
    print("prefs"+studentName);
    return (studentName!= '' && studentNumber != '' && studentClass != -1) ? new MainPage() : _displayContent(context);
  }

  void _getFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentName = prefs.getString(Constants.studentName);
    studentNumber = prefs.getString(Constants.studentNumber);
    studentClass = prefs.getInt(Constants.studentClass);
  }

  Widget _displayContent(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: new AppBar(
        title: new Text("Title", textAlign: TextAlign.center, style: new TextStyle(fontSize: 40.0)),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
      ),
      body: new Container(
          padding: new EdgeInsets.symmetric(),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new RaisedButton(
                  padding: new EdgeInsets.fromLTRB(142.0, 16.0, 142.0, 16.0),
                  color: Colors.lightBlueAccent,
                  elevation: 0.0,
                  child: new Text("Login", textScaleFactor: 1.2),
                  onPressed: (() => Navigator.of(context).pushNamed('login_page')),
                ),

                new Container(padding: new EdgeInsets.only(top: 16.0)),

                new RaisedButton(
                  padding: new EdgeInsets.fromLTRB(132.0, 16.0, 132.0, 16.0),
                  color: Colors.lightBlueAccent,
                  elevation: 0.0,
                  child: new Text("Register", textScaleFactor: 1.2),
                  onPressed: (() => Navigator.of(context).pushNamed('register_page')),
                ),

                new Container(padding: new EdgeInsets.only(top: 32.0)),
              ],
            ),
          )
      ),
    );
  }




}
