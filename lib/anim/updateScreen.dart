
import 'package:firestoredemo/anim/todoList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdateScreen extends StatefulWidget {
  String id;
  UpdateScreen({this.id});
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("todoSet");
  final _formKey = GlobalKey<FormState>();
  String _dropdownValue = "Yes" ;
  List list= ["Yes" , "No"];
  final todoUpdated = TextEditingController() ;
  Todo todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todo App"),
      ),
      body: SafeArea(
        child: Container(
          
          child: AlertDialog(
            title: Text("Update the Todo"),
            content: Form(
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Flexible(
                        child: TextFormField(
                          controller: todoUpdated,
                          //initialValue: _showValue(widget.id),
                          decoration: InputDecoration(
                            labelText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Todo Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: DropdownButtonFormField<String>(
                        value: _dropdownValue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: "Completed",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          )
                        ),
                        hint: Text("Completed"),
                        items: <String>['Yes','No'].map((String value){
                          return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value)
                          );
                        }).toList(),
//                list.map((String value) {
//                  return new DropdownMenuItem<String>(
//                    value: value,
//                    child: new Text(value),
//                  );
//                }).toList(),
                        onChanged: (String val) {
                          setState(() {
                            _dropdownValue = val; 
                          });
                        },
                      ),
                    ),
                  ],
                )),
            actions: [
              FlatButton(child: Text("OK"),
                onPressed: () {
                 dbRef.child(widget.id).update({
                   "todo" : todoUpdated.text,
                   "completed" : _dropdownValue == "Yes" ? true : false ,
                 });
                  Navigator.of(context).pop();
                },),

            ],
          ),
//          Column(
//            children: <Widget>[
//
////              RaisedButton(
////                  child: Icon(Icons.bluetooth_searching,size: 45.0,),
////                  onPressed:(){
////                    Navigator.pop(context);
////                  }),
//            ],
//          ),

        ),
      ),

    );
  }
}
//_showValue(String id){
//  final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("todoSet").child(id);
//  return dbRef.once();
//}


//showAlertDialog(BuildContext context) {
//
//
//  // set up the button
//  Widget okButton = FlatButton(
//    child: Text("OK"),
//    onPressed: () {
//      Navigator.of(context).pop();
//    },
//  );
//
//  // set up the AlertDialog
//  AlertDialog alert = AlertDialog(
//    title: Text("Update the Todo"),
//    content: Form(
//        autovalidate: true,
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(20.0),
//              child: TextFormField(
//                decoration: InputDecoration(
//                  labelText: "Change Todo",
//                  enabledBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(10.0),
//                  ),
//                ),
//                // The validator receives the text that the user has entered.
//                validator: (value) {
//                  if (value.isEmpty) {
//                    return 'Enter Todo Name';
//                  }
//                  return null;
//                },
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.all(20.0),
//              child: DropdownButton<String>(
//                value: _dropdownValue,
//                icon: Icon(Icons.arrow_downward),
//                decoration: InputDecoration(
//                  labelText: "Completed",
//                  enabledBorder: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(10.0),
//                  ),
//                ),
//                hint: Text("Completed"),
//                items: <String>['Yes','No'].map((String value){
//                  return new DropdownMenuItem<String>(
//                      value: value,
//                      child: new Text(value)
//                  );
//                }).toList(),
////                list.map((String value) {
////                  return new DropdownMenuItem<String>(
////                    value: value,
////                    child: new Text(value),
////                  );
////                }).toList(),
//                onChanged: (String val) {
//                    _dropdownValue = val;
//
//
//
//                },
//
//              ),
//            ),
//          ],
//        )),
//    actions: [
//      okButton,
//    ],
//  );
//
//  // show the dialog
//  showDialog(
//    context: context,
//    builder: (BuildContext context) {
//      return alert;
//    },
//  );
//}
//
