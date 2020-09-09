import 'package:flutter/material.dart';
import 'login_signUp_page.dart';

void main() => runApp(new MyAppStart());

class MyAppStart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Login Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new LoginSignUpPage()
    );
  }
}


// this is older half
//SafeArea(
//child: Scaffold(
//appBar: AppBar(
//title: Text("hello"),
//),
//body: Center(
//child: FlatButton(
//color: Colors.blue,
//onPressed: (){
//sendData();
//},
//child: Text("press to send data")
//),
//),
//),
//)
