import 'dart:io';

import 'package:flutter/material.dart';
import 'package:licenta/model/teacher.dart';
import 'package:licenta/presenters/teachers_body_presenter.dart';
import 'package:licenta/utils/colors_constant.dart';
import 'package:licenta/utils/native_components.dart';
import 'package:licenta/views/teachers_body_view.dart';


class TeachersBody extends StatefulWidget {
  final String _department;

  TeachersBody(this._department);

  @override
  _TeachersBodyState createState() => new _TeachersBodyState(_department);

}

class _TeachersBodyState extends State<TeachersBody> implements TeachersBodyView {
  String _department;
  TeachersBodyPresenter _teachersBodyPresenter;
  List<Teacher> _teachersList;
  bool _isFetching;


  _TeachersBodyState(this._department){
    _teachersBodyPresenter = new TeachersBodyPresenter(this);
  }


  @override
  void initState() {
    _isFetching = true;
    _loadTeachers();
    super.initState();
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
            itemCount: _teachersList == null ? 0 : _teachersList.length,
            itemBuilder: (BuildContext context, int index) {
              Teacher teacher = _teachersList.elementAt(index);
              return new TeacherCard(teacher);
            },
          )
      );
    }

    return widget;
  }


  _loadTeachers(){
    _teachersBodyPresenter.loadTeachersByDepartment(_department);
  }


  @override
  void onLoadTeachersComplete(List<Teacher> teachers) {
    setState((){
      _isFetching = false;
      _teachersList = teachers;
    });
  }

  @override
  void onLoadTeachersError() {
    // TODO: implement onLoadTeachersError
  }
}


class TeacherCard extends StatelessWidget {
  final Teacher _teacher;

  const TeacherCard(this._teacher);

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: ColorsConstants.backgroundColorBlue,
      elevation: 1.0,
      child: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Image.network(_teacher.photoURL, width: 100.0, height: 120.0, fit: BoxFit.fill,),

            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                new Padding(
                  padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: new Text(_teacher.name,
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),

                new FlatButton(
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.email),
                      new Padding(padding: new EdgeInsets.only(left: 16.0)),
                      new Text(_teacher.email)
                    ],
                  ),
                  onPressed: (){
                    _openMailApp(_teacher.email);
                  }),

                new FlatButton(
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.computer),
                        new Padding(padding: new EdgeInsets.only(left: 16.0)),
                        new Text(_teacher.web)
                      ],
                    ),
                    onPressed: (){
                      _openBrowserApp(_teacher.web);
                    }),

                new FlatButton(
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.location_on),
                        new Padding(padding: new EdgeInsets.only(left: 16.0)),
                        new Text(_teacher.address)
                      ],
                    ),
                    onPressed: () {
                      _openMapsApp(_teacher.address);
                    }),
              ]
            )
          ],
        ),
      ),
    );
  }


  void _openMapsApp(String address){
    if (_checkPlatform()) {
      try {
        NativeComponents.openMapsApp(address);
      } catch(e) {
        print("Open maps $e");
      }
    }
  }

  void _openBrowserApp(String web){
    if (_checkPlatform()) {
      try {
        NativeComponents.openBrowserApp(web);
      } catch (e){
        print("Open browser $e");
      }
    }
  }

  void _openMailApp(String email){
    if (_checkPlatform()) {
      try {
        NativeComponents.openMailApp(email);
      } catch (e){
        print("Open email $e");
      }
    }
  }

  bool _checkPlatform() {
    return Platform.isAndroid == true;
  }



}