import 'package:flutter/material.dart';
import 'package:licenta/model/course.dart';
import 'package:licenta/utils/colors_constant.dart';
import 'package:licenta/views/courses_body_view.dart';
import 'package:licenta/presenters/courses_body_presenter.dart';


class CoursesBody extends StatefulWidget{
  String day = '';

  CoursesBody(this.day);

  @override
  CoursesBodyState createState() => new CoursesBodyState(day);
}


class CoursesBodyState extends State<CoursesBody> implements CoursesBodyView{
  String _day = '';
  List<Course> _coursesList;
  CoursesBodyPresenter _coursesPresenter;
  bool _isFetching;

  CoursesBodyState(this._day){
    _coursesPresenter = new CoursesBodyPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isFetching = true;
    _coursesPresenter.loadCoursesByDay(_day);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (_isFetching){
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
                elevation: 1.0,
                color: ColorsConstants.backgroundColorBlue,
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
                          color: ColorsConstants.primaryColor,
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new FlatButton(
                                  child: new Row(
                                      children: <Widget>[
                                        new Icon(Icons.add),
                                        new Text("Add", style: new TextStyle(
                                            fontSize: 16.0)),
                                      ]
                                  ),
                                  onPressed: () {
                                    _addMyCourse(course);
                                  },
                                ),
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

  _addMyCourse(Course myCourse) {
    _coursesPresenter.addToMyCourses(myCourse);
  }

  _deleteMyCourse(Course myCourse) {
    _coursesPresenter.deleteFromMyCourses(myCourse);
  }

  @override
  void onAddToMyCoursesComplete() {
    // TODO: implement onAddToMyCoursesComplete
  }

  @override
  void onAddToMyCoursesError(String errorMessage) {
    print("Error Message: $errorMessage");
  }

  @override
  void onDeleteFromMyCoursesComplete() {
    // TODO: implement onDeleteFromMyCoursesComplete
  }

  @override
  void onDeleteFromMyCoursesError(String errorMessage) {
    print("Error Message: $errorMessage");
  }

  @override
  void onLoadCoursesComplete(List<Course> courses) {
    setState((){
      _coursesList = courses;
      _isFetching = false;
    });
  }

  @override
  void onLoadCoursesError() {
    // TODO: implement onLoadCoursesError
  }


}
