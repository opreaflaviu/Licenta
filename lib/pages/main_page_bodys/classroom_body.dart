import 'package:flutter/material.dart';

class ClassroomBody extends StatefulWidget{
  @override
  ClassroomBodyState createState() => new ClassroomBodyState();
}

class ClassroomBodyState extends State<ClassroomBody> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Text('classroom body')
    );
  }


}