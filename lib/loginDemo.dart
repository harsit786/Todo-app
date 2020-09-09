import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoredemo/anim/firstScreen.dart';
import 'package:firestoredemo/anim/secondScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

//void main() {
//  runApp(MyApp());
//}
//

class MyApp extends StatefulWidget {
  final FirebaseUser user;

  const MyApp({
    Key key,
    @required this.user
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("pathDemo");

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

   void _emailVerified() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: DefaultTabController(
          length: 2,
          child:SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("Todo App"),
                  bottom: TabBar(
                      labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0
                      ),
                      indicatorWeight: 1.0,
                      indicatorColor: Colors.blue,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.red,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Create",
                            style: TextStyle(
                              fontSize: 18.0,
                              color:Colors.white,
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Read",
                            style: TextStyle(
                              fontSize: 18.0,
                              color:Colors.white,
                            ),),
                        )
                      ]

                  ),
                ),
                body:TabBarView(
                    children: [
                      FirstScreen(),
                      SecondScreen()
                    ]),

              ),

          ),

      ),

    );

  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.isEmailVerified;
  }
}
