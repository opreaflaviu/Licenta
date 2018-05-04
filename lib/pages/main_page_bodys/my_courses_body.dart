import 'package:flutter/material.dart';
import 'package:licenta/model/course.dart';
import 'package:licenta/views/my_courses_body_view.dart';
import 'package:licenta/presenters/my_course_body_presenter.dart';


class MyCoursesBody extends StatefulWidget{
  String _day = '';

  MyCoursesBody(this._day);

  @override
  MyCoursesBodyState createState() => new MyCoursesBodyState(_day);
}


class MyCoursesBodyState extends State<MyCoursesBody> implements MyCoursesBodyView{
  String _day = '';
  MyCoursesBodyPresenter _myCoursesPresenter;
  List<Course> _coursesList;
  bool _isFetching;

  MyCoursesBodyState(this._day){
    _myCoursesPresenter = new MyCoursesBodyPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isFetching = true;
    _loadMyCourses();
  }

  _loadMyCourses() {
    _myCoursesPresenter.loadMyCoursesByDay(_day);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (_isFetching) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );

    } else {
      widget = new Container(
          padding: new EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: new ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _coursesList == null ? 0 : _coursesList.length,
            itemBuilder: (BuildContext context, int index) {
              Course course = _coursesList.elementAt(index);
              return new Card(
                child: new Padding(
                    padding: new EdgeInsets.only(top: 8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        new Text(course.courseName,
                            style: new TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold
                            )),

                        new Padding(padding: new EdgeInsets.only(top: 12.0)),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text('Hour: ' + course.courseHour,
                                style: new TextStyle(fontSize: 16.0)),
                            new Text('Room: ' + course.courseRoom,
                                style: new TextStyle(fontSize: 16.0)),
                            new Text(course.courseFrequency.toString(),
                                style: new TextStyle(fontSize: 16.0))
                          ],
                        ),

                        new Padding(padding: new EdgeInsets.only(top: 12.0)),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(course.courseType.toString() + ' ',
                                textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 16.0)),
                            new Text(course.courseTeacher,
                                textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 16.0))
                          ],
                        ),

                        new Padding(padding: new EdgeInsets.only(top: 12.0)),

                        new Container(
                          color: Colors.amber,
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new FlatButton(
                                  child: new Row(
                                      children: <Widget>[
                                        new Icon(Icons.remove),
                                        new Text("Remove", style: new TextStyle(
                                            fontSize: 16.0)),
                                      ]
                                  ),
                                  onPressed: () {
                                    _deleteMyCourse(course);
                                  },
                                )
                              ]
                          ),
                        )
                      ],
                    )
                ),
              );
            },
          )
      );
    }
    return widget;
  }

  _deleteMyCourse(Course myCourse) {
    _myCoursesPresenter.deleteFromMyCourses(myCourse);
    _loadMyCourses();
  }

  @override
  void onDeleteFromMyCoursesComplete() {
    // TODO: implement onDeleteFromMyCoursesComplete
  }

  @override
  void onDeleteFromMyCoursesError() {
    // TODO: implement onDeleteFromMyCoursesError
  }

  @override
  void onLoadCoursesComplete(List<Course> myCourses) {
    setState((){
      _coursesList = myCourses;
      _isFetching = false;
    });
  }

  @override
  void onLoadCoursesError() {
    // TODO: implement onLoadCoursesError
  }

}