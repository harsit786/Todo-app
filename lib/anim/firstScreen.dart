import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'todoList.dart';
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      height: double.infinity,
//      width: double.infinity,
     child: MyCustomForm()
    );
  }
}
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  //final snackBar = SnackBar(content: Text("A New TODO added"));
  final _formKey = GlobalKey<FormState>();
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("todoSet");
  final todoController = TextEditingController();
  int _userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _userId = 0;
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
//                onSaved: (value){
//                   _subject = value;
//                },
                  controller: todoController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Type TODO',
                    labelStyle: TextStyle(
                      fontSize: 24.0,

                    ),

                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }else{
                      return null;
                    }

                  },
                ),
              ),


              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                color: Colors.cyanAccent,
                  child:Text("Add TODO",style: TextStyle(

                  ),),
                  onPressed: (){
//                    print(_userId);
                  if(_formKey.currentState.validate()) {
//                    _formKey.currentState.save();
                    _userId++;
                    dbRef.push().set({
                      "id": _userId,
                      "todo": todoController.text,
                      "completed": false,
                    }).then((_) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Successfully Added')));
                      todoController.clear();
                      
                    }).catchError((onError){
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(onError)));
                    });

                  }

              }),
//              RaisedButton(
//                  color: Colors.cyanAccent,
//                  child:Text("Read Todo",style: TextStyle(
//
//                  ),),
//                  onPressed: (){
//                      readData();
//                  }),
            ]
        )
    );
  }


//  void readData() {
//    dbRef.once().then((DataSnapshot dataSnapshot) => {
//      print(dataSnapshot.value),
//
//    });
//  }
}
