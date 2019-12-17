import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_demo/pages/home.dart';
import 'package:flutter_ecommerce_demo/pages/login.dart';
import 'package:flutter_ecommerce_demo/pages/products.dart';
import 'package:flutter_ecommerce_demo/pages/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-shop',
      theme: ThemeData(
       brightness: Brightness.dark,
      primaryColor: Colors.cyan[400],
      accentColor: Colors.deepOrange[200],
      textTheme: TextTheme(
        body1: TextStyle(
          fontSize: 18.0
        ),
        headline: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold
        ),
        title: TextStyle(
          fontSize: 36.0,
          fontStyle: FontStyle.italic
        )
      )
      ),
      home: RegisterPage(),
      routes: {
        '/products' : (BuildContext context) => ProductsPage(),
        '/register': (BuildContext context) => RegisterPage(),
        '/login' :(BuildContext context) => LoginPage()
      },
    );
  }
}
