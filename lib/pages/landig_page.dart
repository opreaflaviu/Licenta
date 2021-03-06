import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:licenta/utils/colors_constant.dart';
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
  var studentName;
  var studentClass;
  var studentNumber;

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
      backgroundColor: ColorsConstants.primaryColor,
      key: _scaffoldState,

      body: new Container(
          padding: new EdgeInsets.symmetric(),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FlatButton(
                  highlightColor: ColorsConstants.backgroundColor,
                  padding: new EdgeInsets.fromLTRB(142.0, 16.0, 142.0, 16.0),
                  color: ColorsConstants.backgroundColor,
                  child: new Text("Login", textScaleFactor: 1.2),
                  onPressed: loginWithSharedPrefs
                ),

                new Container(padding: new EdgeInsets.only(top: 16.0)),

                new FlatButton(
                  highlightColor: ColorsConstants.backgroundColor,
                  padding: new EdgeInsets.fromLTRB(132.0, 16.0, 132.0, 16.0),
                  color: ColorsConstants.backgroundColor,
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

  void loginWithSharedPrefs(){
    if (studentName != null && studentClass != null && studentNumber != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('main_page', (Route<dynamic> route) =>false);
    } else {
      Navigator.of(context).pushNamed('login_page');
    }
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
      studentName = sharedPreferences.getString(Constants.studentName);
      studentClass = sharedPreferences.getInt(Constants.studentClass);
      studentNumber = sharedPreferences.getString(Constants.studentNumber);
    });

  }
}
