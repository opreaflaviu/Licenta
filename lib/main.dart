
import 'package:flutter/material.dart';
import './pages/landig_page.dart';
import './pages/login_page.dart';
import './pages/register_page.dart';
import './pages/main_page.dart';

void main() {
  runApp(new MaterialApp(
    routes: <String, WidgetBuilder>{
      'landing_page': (BuildContext context) => new LandingPage(),
      'login_page': (BuildContext context) => new LoginPage(),
      'register_page': (BuildContext context) => new RegisterPage(),
      'main_page': (BuildContext context) => new MainPage()
    },    
    home: new LandingPage()  
    )
  );
} 


