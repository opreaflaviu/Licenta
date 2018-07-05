import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:licenta/model/server_response.dart';
import 'package:licenta/model/student.dart';
import 'package:licenta/pages/main_page_bodys/attendance_body.dart';
import 'package:licenta/pages/main_page_bodys/news_body.dart';
import 'package:licenta/pages/main_page_bodys/saved_news_body.dart';
import 'package:licenta/pages/main_page_bodys/teachers_body.dart';
import 'package:licenta/utils/colors_constant.dart';
import 'package:licenta/utils/shared_preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';
import './main_page_bodys/courses_body.dart';
import './main_page_bodys/my_courses_body.dart';
import './main_page_bodys/classroom_body.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  static Widget _body;
  static TabController _tabController;
  static Widget _bottomBarNavigation;
  static Widget _scanFAB;
  static String _title;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 0, length: 5, vsync: this);
    setNewsBody();
  }

  @override
  Widget build(BuildContext context) {
    return displayContent(context);
  }

  Widget displayContent(BuildContext context) {
    return new Scaffold(
        backgroundColor: ColorsConstants.backgroundColor,
        appBar: new AppBar(
          title: new Text(_title,
            textAlign: TextAlign.center, style: new TextStyle(fontSize: 32.0, color: Colors.black54)),
          centerTitle: true,
          backgroundColor: ColorsConstants.primaryColor,
          elevation: 0.0,
        ),

        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new Container(
                  color: Colors.white,
                  child: new DrawerHeader(
                      child: new Image.asset('assets/ubb_logo.png'))),
              new Container(
                color: Colors.white,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new _UserDetails(),
                    new Padding(padding: new EdgeInsets.only(top: 30.0)),
                    new _IconButton(Icons.event_note, 'News', () {
                      _changeToNews();
                    }, Colors.black54, Colors.black54),
                    new _IconButton(Icons.schedule, 'Courses', () {
                      _changeToCourses();
                    }, Colors.black54, Colors.black54),
                    new _IconButton(Icons.assignment, 'My Courses', () {
                      _changeToMyCourses();
                    }, Colors.black54, Colors.black54),
                    new _IconButton(Icons.business, 'Classrooms', () {
                      _changeToClassroom();
                    }, Colors.black54, Colors.black54),
                    new _IconButton(Icons.group, 'Teachers', () {
                      _changeToTeachers();
                    }, Colors.black54, Colors.black54),
                    new _IconButton(Icons.add, 'Attendance', () {
                      _changeToAttendance();
                    }, Colors.black54, Colors.black54),
                    new Padding(padding: new EdgeInsets.only(top: 24.0)),
                    /*new _IconButton(Icons.account_box, 'Acount', () {
                      print("Acount");
                    }, Colors.black54, Colors.black54),*/
                    new _IconButton(Icons.block, 'Logout', (){
                      logout();
                    }, Colors.black54, Colors.black54)
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _bottomBarNavigation,
        body: _body,
        floatingActionButton: _scanFAB,);
  }


  void logout(){
    new SharedPreferencesUtils().logoutStudent();
    Navigator.of(context).pushNamedAndRemoveUntil('landing_page', (Route<dynamic> route) =>false);
  }

  void setNewsBody() {
    _scanFAB = null;
    _title = "News";
    _body = _getTabViewNews();
    _bottomBarNavigation = new _NavigationBarNews(_tabController);
  }

  void _onChangeToNews() {
    setState((){
      setNewsBody();
    });
  }

  void _onChangeToCourses() {
    setState(() {
      _title = "Courses";
      _scanFAB = null;
      _body = _getTabViewCourses();
      _bottomBarNavigation = new NavigationBarCourses(_tabController);
    });
  }

  void _onChangeToMyCourses() {
    setState(() {
      _title = "My Courses";
      _scanFAB = null;
      _body = _getTabViewMyCourses();
      _bottomBarNavigation = new NavigationBarCourses(_tabController);
    });
  }

  void _onChangeToTeachers() {
    setState(() {
      _title = "Teachers";
      _scanFAB = null;
      _body = _getTabViewTeachers();
      _bottomBarNavigation = new _NavigationBarTeachers(_tabController);
    });
  }

  void _changeToAttendance() {
    Navigator.of(context).pop();
    setState((){
      _title = "Attendance";
      _scanFAB = new _ScanFAB();
      _body = new AttendanceBody();
      _bottomBarNavigation = null;
    });
  }


  _changeToNews(){
    Navigator.of(context).pop();
    _onChangeToNews();
  }

  _changeToCourses() {
    Navigator.of(context).pop();
    _onChangeToCourses();
  }

  _changeToMyCourses() {
    Navigator.of(context).pop();
    _onChangeToMyCourses();
  }

  _changeToTeachers() {
    Navigator.of(context).pop();
    _onChangeToTeachers();
  }

  _changeToClassroom() {
    Navigator.of(context).pop();
    setState((){
      _title = "Classrooms";
      _scanFAB = null;
      _body = new ClassroomBody();
      _bottomBarNavigation = null;
    });

  }


  _getTabViewNews() {
    return new TabBarView(controller: _tabController, children: <Widget>[
      new NewsBody(),
      new SavedNewsBody(),
    ]);
  }

  _getTabViewCourses() {
    return new TabBarView(controller: _tabController, children: <Widget>[
      new CoursesBody(Constants.monday),
      new CoursesBody(Constants.tuesday),
      new CoursesBody(Constants.wednesday),
      new CoursesBody(Constants.thursday),
      new CoursesBody(Constants.friday)
    ]);
  }

  _getTabViewMyCourses() {
    return new TabBarView(controller: _tabController, children: <Widget>[
      new MyCoursesBody(Constants.monday),
      new MyCoursesBody(Constants.tuesday),
      new MyCoursesBody(Constants.wednesday),
      new MyCoursesBody(Constants.thursday),
      new MyCoursesBody(Constants.friday)
    ]);
  }

  _getTabViewTeachers() {
    return new TabBarView(controller: _tabController, children: <Widget>[
      new TeachersBody(Constants.CS),
      new TeachersBody(Constants.Math),
    ]);
  }

  _changeTo(Widget body) {
    Navigator.of(context).pop();
    setState(() {
      _body = body;
      _bottomBarNavigation = null;
    });
  }
}


class _NavigationBarNews extends StatelessWidget {
  TabController _controller;

  _NavigationBarNews(this._controller);

  @override
  Widget build(BuildContext context) {
    return new TabBar(
      controller: _controller,
      isScrollable: false,
      labelColor: Colors.black54,
      indicatorColor: Colors.black54,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4.0,
      tabs: <Tab>[
        new Tab(text: "News"),
        new Tab(text: "Saved News"),
      ],
    );
  }
}

class NavigationBarCourses extends StatelessWidget {
  TabController _controller;

  NavigationBarCourses(this._controller);

  @override
  Widget build(BuildContext context) {
    return new TabBar(
      controller: _controller,
      isScrollable: false,
      labelColor: Colors.black54,
      indicatorColor: Colors.black54,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4.0,
      tabs: <Tab>[
        new Tab(text: Constants.monday),
        new Tab(text: Constants.tuesday),
        new Tab(text: Constants.wednesday),
        new Tab(text: Constants.thursday),
        new Tab(text: Constants.friday),
      ],
    );
  }
}

class _NavigationBarTeachers extends StatelessWidget {
  TabController _controller;

  _NavigationBarTeachers(this._controller);

  @override
  Widget build(BuildContext context) {
    return new TabBar(
      controller: _controller,
      isScrollable: false,
      labelColor: Colors.black54,
      indicatorColor: Colors.black54,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4.0,
      tabs: <Tab>[
        new Tab(text: Constants.CS),
        new Tab(text: Constants.Math),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  IconData _icon;
  String _text;
  VoidCallback _method;
  Color _textColor;
  Color _iconColor;

  _IconButton(
      this._icon, this._text, this._method, this._textColor, this._iconColor);

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
        child: new Row(children: <Widget>[
          new Icon(_icon, color: _iconColor),
          new Padding(padding: new EdgeInsets.only(left: 16.0)),
          new Text(_text,
              style: new TextStyle(fontSize: 16.0, color: _textColor)),
        ]),
        onPressed: _method);
  }
}

class _UserDetails extends StatefulWidget {
  var _studentName = '';
  var _studentClass = '';

  @override
  _UserDetailsState createState() => new _UserDetailsState();
}

class _UserDetailsState extends State<_UserDetails> {
  var _studentName = '';
  var _studentClass = '';
  Future<SharedPreferences> _sharedPrefs = SharedPreferences.getInstance();

  getFromSharedPrefs() async {
    final SharedPreferences sharedPreferences = await _sharedPrefs;
    setState(() {
      _studentName = sharedPreferences.getString(Constants.studentName);
      _studentClass = 'Class ' +
          sharedPreferences.getInt(Constants.studentClass).toString();
    });
  }

  _UserDetailsState() {
    getFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left: 16.0),
            child: new Text(_studentName,
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
          new Padding(
            padding: new EdgeInsets.only(left: 16.0),
            child: new Text(
              _studentClass,
              style: new TextStyle(fontSize: 16.0),
            ),
          ),
        ]);
  }
}


class _ScanFAB extends StatefulWidget {
  @override
  _ScanFABState createState() => new _ScanFABState();

}

class _ScanFABState extends State<_ScanFAB> {
  Permission permission = Permission.Camera;

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
      onPressed: _scan,
      child: new Icon(
          Icons.add
      ),
    );
  }


  _scan() async {
    try {
      String reader = await BarcodeScanner.scan();

      if(!mounted){
        return;
      }

      await _sendAttendanceToServer(reader);
    } on PlatformException catch(e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
      } else {
        print("unknown error PlatformExceprion ========= $e");
      }
    } on FormatException {
      print("user return without scanning");
    } catch(e) {
      print("unknown error FormatException ========= $e");
    }
  }

  _sendAttendanceToServer(String reader) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> readerData = reader.split('-');
    String courseName = readerData.elementAt(0);
    String courseType = readerData.elementAt(1);
    String attendanceDate = readerData.elementAt(2);
    String studentNumber = sharedPreferences.getString(Constants.studentNumber);

    var response = await http.post(
        Uri.encodeFull(
            Constants.apiRoot + "/attendance/add"),
        headers: {
          "Accept": "appication/json"
        },
        body: {
          Constants.courseName : "$courseName",
          Constants.courseType : "$courseType",
          Constants.attendanceDate : "$attendanceDate",
          Constants.studentNumber: "$studentNumber"
        });

    Map data = JSON.decode(response.body);
    return new ServerResponse.fromMap(data);
  }

}