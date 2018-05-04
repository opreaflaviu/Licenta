import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../pages/main_page.dart';
import '../model/student.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connSub;
  static Widget _content;

  LandingPageState(){
    getFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    _content = _displayContent(context);
    return _content;
  }

  Widget _displayContent(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.greenAccent,
      key: _scaffoldState,
      appBar: new AppBar(
        title: new Text("Title",
            textAlign: TextAlign.center, style: new TextStyle(fontSize: 40.0)),
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
                  onPressed: (() =>
                      Navigator.of(context).pushNamed('login_page')),
                ),
                new Container(padding: new EdgeInsets.only(top: 16.0)),
                new RaisedButton(
                  padding: new EdgeInsets.fromLTRB(132.0, 16.0, 132.0, 16.0),
                  color: Colors.lightBlueAccent,
                  elevation: 0.0,
                  child: new Text("Register", textScaleFactor: 1.2),
                  onPressed: (() =>
                      Navigator.of(context).pushNamed('register_page')),
                ),
                new Container(padding: new EdgeInsets.only(top: 32.0)),
              ],
            ),
          )),
    );
  }

  void _showSnackBar(var snackBarText) {
    _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Padding(
      padding: new EdgeInsets.only(left: 32.0, top: 4.0, bottom: 6.0),
      child: new Text(
        snackBarText != ConnectivityResult.none ? "Connected" : "No Connection",
        style: new TextStyle(fontSize: 16.0),
      ),
    )));
  }

  void initState() {
    super.initState();
    _connSub = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _showSnackBar(result);
    });
  }

  Future<Null> initPlatform() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
      result = null;
    }
    if (!mounted) return;
    _showSnackBar(result);
  }

  @override
  void dispose() {
    _connSub?.cancel();
    super.dispose();
  }

  getFromSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState((){
      var studentName = sharedPreferences.getString(Constants.studentName);
      var studentClass = sharedPreferences.getInt(Constants.studentClass);
      var studentNumber = sharedPreferences.getString(Constants.studentNumber);
      print("Student:    $studentName, $studentNumber, $studentClass");
      if (studentName != null && studentClass != null && studentNumber != null) {
        _content = new MainPage();
      }
    });

  }
}
