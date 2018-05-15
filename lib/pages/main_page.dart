import 'dart:async';
import 'package:flutter/material.dart';
import 'package:licenta/pages/main_page_bodys/teachers_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import './main_page_bodys/courses_body.dart';
import './main_page_bodys/my_courses_body.dart';
import './main_page_bodys/classroom_body.dart';
import 'package:material_search/material_search.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static Widget _body;
  static TabController _tabController;
  static Widget _bottomBarNavigation;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return displayContent(context);
  }

  Widget displayContent(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: new AppBar(
          /*title: new Text("MainPage",
            textAlign: TextAlign.center, style: new TextStyle(fontSize: 40.0)),*/
          centerTitle: true,
          backgroundColor: Colors.teal[600],
          elevation: 0.0,
          actions: <Widget>[
            new Padding(
                padding: new EdgeInsets.only( right: 80.0),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 90.0,
                      child: new TextField(
                        decoration: new InputDecoration(
                            suffixIcon: new Icon(Icons.search), labelText: "Search..."),
                      ),
                    ),
                  ],
                )),
          ],
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
                    new UserDetails(),
                    new Padding(padding: new EdgeInsets.only(top: 30.0)),
                    new IconButton(Icons.event_note, 'News', () {
                      _changeTo(new ClassroomBody());
                    }, Colors.black54, Colors.black54),
                    new IconButton(Icons.schedule, 'Courses', () {
                      _changeToCourses();
                    }, Colors.black54, Colors.black54),
                    new IconButton(Icons.assignment, 'My Courses', () {
                      _changeToMyCourses();
                    }, Colors.black54, Colors.black54),
                    new IconButton(Icons.business, 'Classrooms', () {
                      _changeTo(new ClassroomBody());
                    }, Colors.black54, Colors.black54),
                    new IconButton(Icons.group, 'Teachers', () {
                      _changeToTeachers();
                    }, Colors.black54, Colors.black54),
                    new Padding(padding: new EdgeInsets.only(top: 24.0)),
                    new IconButton(Icons.account_box, 'Acount', () {
                      print("Acount");
                    }, Colors.black54, Colors.black54),
                    new IconButton(Icons.block, 'Logout', () {
                      print('Logout');
                    }, Colors.black54, Colors.black54)
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _bottomBarNavigation,
        body: _body);
  }

  void _onChangeToCourses() {
    setState(() {
      _body = _getTabViewCourses();
      _bottomBarNavigation = new NavigationBarCourses(_tabController);
    });
  }

  void _onChangeToMyCourses() {
    setState(() {
      _body = _getTabViewMyCourses();
      _bottomBarNavigation = new NavigationBarCourses(_tabController);
    });
  }

  void _onChangeToTeachers() {
    setState(() {
      _body = _getTabViewTeachers();
      _bottomBarNavigation = new NavigationBarTeachers(_tabController);
    });
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
      new TeachersBody(Constants.CSH),
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
      unselectedLabelColor: Colors.teal[600],
    );
  }
}

class NavigationBarTeachers extends StatelessWidget {
  TabController _controller;

  NavigationBarTeachers(this._controller);

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
        new Tab(text: Constants.CSH),
      ],
      unselectedLabelColor: Colors.teal[600],
    );
  }
}

class IconButton extends StatelessWidget {
  IconData _icon;
  String _text;
  VoidCallback _method;
  Color _textColor;
  Color _iconColor;

  IconButton(
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

class UserDetails extends StatefulWidget {
  var _studentName = '';
  var _studentClass = '';

  @override
  UserDetailsState createState() => new UserDetailsState();
}

class UserDetailsState extends State<UserDetails> {
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

  UserDetailsState() {
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
