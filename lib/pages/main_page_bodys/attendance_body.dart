import 'package:flutter/material.dart';
import 'package:licenta/presenters/attendance_presenter.dart';
import 'package:licenta/utils/colors_constant.dart';
import 'package:licenta/views/attendance_body_view.dart';
import 'package:quiver/collection.dart';

class AttendanceBody extends StatefulWidget {
  @override
  AttendanceBodyState createState() => new AttendanceBodyState();
}

class AttendanceBodyState extends State<AttendanceBody>
    implements AttendanceBodyView {

  Multimap<String, String> _attendanceList;
  AttendancePresenter _presenter;
  bool _isFetching;

  AttendanceBodyState() {
    _presenter = new AttendancePresenter(this);
    _attendanceList = new Multimap();
  }

  @override
  void initState() {
    _isFetching = true;
    _presenter.getAttendanceList();
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
      widget = new ListView.builder(
          itemCount: _attendanceList == null ? 0 : _attendanceList.length,
          itemBuilder: (context, index) {
            String name = _attendanceList.keys.elementAt(index);
            return new ExpansionTile(
                backgroundColor: ColorsConstants.backgroundColorBlue,
                title: new Padding(
                  padding: new EdgeInsets.only(left: 20.0),
                  child:
                  new Container(
                    alignment: Alignment.center,
                    child: new Text(
                        name,
                        style: new TextStyle(
                          fontSize: 20.0,
                        )),
                  )

                ),

                children: _attendanceList[name].toList().map((val) => new ListTile(
                    title: new Padding(
                        padding: new EdgeInsets.only(left: 0.0),
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: new Text(val,
                            style: new TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                            ),
                          ),
                        )

                    )
                )).toList()
            );
          }
      );
    }
    return widget;
  }

  @override
  void onLoadAttendanceComplete(Multimap<String, String> attendanceList) {
    setState(() {
      _attendanceList = attendanceList;
      _isFetching = false;
    });
  }

  @override
  void onLoadAttendanceError() {
    // TODO: implement onLoadAttendanceError
  }

}