import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.greenAccent,

      appBar: new AppBar(
        title: new Text("MainPage",
            textAlign: TextAlign.center, style: new TextStyle(fontSize: 40.0)),
        centerTitle: true,
        backgroundColor: Colors.teal[600],
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
                  new Padding(                    
                    padding: new EdgeInsets.only(left: 16.0),
                    child: new Text("Oprea Flaviu",
                      style: new TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(left: 16.0),
                    child: new Text(
                      "Class 233",
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),

                  new Padding(padding: new EdgeInsets.only(top: 30.0)),
                  new FlatButton.icon(
                      label: new Text('Schedule',
                          style: new TextStyle(
                          color: Colors.black54, fontSize: 16.0)),
                      icon: new Icon(Icons.schedule, color: Colors.black54)),
                  new FlatButton.icon(
                      label: new Text('Classrooms',
                          style: new TextStyle(
                          color: Colors.black54, fontSize: 16.0)),
                      icon: new Icon(Icons.business, color: Colors.black54)),
                  new FlatButton.icon(
                      label: new Text('Teachers',
                          style: new TextStyle(
                          color: Colors.black54, fontSize: 16.0)),
                      icon: new Icon(Icons.group, color: Colors.black54)),

                  new Padding(
                    padding: new EdgeInsets.only(top: 24.0)
                  ),

                  new FlatButton.icon(
                      label: new Text('Acount',
                          style:new TextStyle(color: Colors.black54, fontSize: 16.0)),
                      icon: new Icon(Icons.account_box, color: Colors.black54),
                  ),
                  new FlatButton.icon(
                      label: new Text('Logout',
                          style:new TextStyle(color: Colors.black54, fontSize: 16.0)),
                      icon: new Icon(Icons.block, color: Colors.black54),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
