import 'dart:io';

import 'package:flutter/material.dart';
import 'package:licenta/model/classroom.dart';
import 'package:licenta/presenters/classroom_presenter.dart';
import 'package:licenta/utils/colors_constant.dart';
import 'package:licenta/utils/native_components.dart';
import 'package:licenta/views/classroom_body_view.dart';

class ClassroomBody extends StatefulWidget {
  @override
  _ClassroomBodyState createState() => new _ClassroomBodyState();
}

class _ClassroomBodyState extends State<ClassroomBody>
    implements ClassroomBodyView {
  ClassroomPresenter _classroomPresenter;
  List<Classroom> _classroomList;
  bool _isFetching;

  _ClassroomBodyState() {
    _classroomPresenter = new ClassroomPresenter(this);
    _classroomList = new List<Classroom>();
  }

  @override
  void initState() {
    _isFetching = true;
    _classroomPresenter.loadClassroomList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (_isFetching) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Container(
          padding: new EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: new ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _classroomList == null ? 0 : _classroomList.length,
            itemBuilder: (BuildContext context, int index) {
              Classroom classroom = _classroomList.elementAt(index);
              return new _ClassroomCard(classroom);
            },
          ));
    }
    return widget;
  }

  @override
  void onLoadClassroomComplete(List<Classroom> classroomList) {
    print("Load complete");
    classroomList.forEach((c) {
      print("dasdasdas    ${c.toString()}");
    });

    setState(() {
      _classroomList = classroomList;
      _isFetching = false;
    });
  }

  @override
  void onLoadClassroomError() {
    // TODO: implement onLoadClassroomError
  }
}


class _ClassroomCard extends StatelessWidget {
  final Classroom _classroom;

  const _ClassroomCard(this._classroom);

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: ColorsConstants.backgroundColorBlue,
      elevation: 1.0,
      child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
              children: <Widget>[

                new Container(
                  child: new Text(
                    _classroom.name,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                ),

                new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.only(left: 16.0),
                            child: new Icon(Icons.business),),
                          new Padding(
                            padding: new EdgeInsets.only(left: 16.0),
                            child:
                              new Text(_classroom.building,
                                style: new TextStyle(fontWeight: FontWeight.bold)
                            )
                          ),
                        ],
                      ),
                      new FlatButton(
                          child: new Row(
                            children: <Widget>[
                              new Icon(Icons.location_on),
                              new Padding(padding: new EdgeInsets.only(left: 16.0)),
                              new Text(_classroom.address)
                            ],
                          ),
                          onPressed: () {
                            _openMapsApp(_classroom.address);
                          }),
                    ]
                )
          ]
          )
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

  bool _checkPlatform() {
    return Platform.isAndroid == true;
  }
}
