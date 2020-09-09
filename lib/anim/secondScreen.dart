


import 'package:firebase_database/firebase_database.dart';
import 'package:firestoredemo/anim/todoList.dart';
import 'package:firestoredemo/anim/updateScreen.dart';
import 'package:flutter/material.dart';



class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("todoSet");
  //final DatabaseReference dbReference = FirebaseDatabase.instance.reference().child("todoSet").orderByChild('id');

  DatabaseReference todoRef;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final FirebaseDatabase database = FirebaseDatabase.instance;
    todoRef = database.reference().child("todoSet");


  }

  @override
  Widget build(BuildContext context) {
    String id ="";
    return Container(

      child: StreamBuilder(
          stream: dbRef.orderByChild("id").onValue,
          builder: (context, snap){
            if(snap.hasData){

              Map values = snap.data.snapshot.value;
              List item= [];
              values.forEach((key, data) => item.add({"key": key, ...data}));
//              values.forEach((key, values) {
//                item.add(values);
//              });
////


              return new ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("${item[index]["todo"]}",
                        // ${item[index]["key"]}
                        style: TextStyle(
                          color: Colors.black,
//                          fontSize: 15.0,
//                          fontWeight: FontWeight.bold,
                        ),),
                      leading: IconButton(
                          icon: item[index]["completed"] ?
                          Icon(Icons.check,color: Colors.green,) :
                          Icon(Icons.clear,color: Colors.red,) , onPressed: null),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          InkWell(
                      child: Icon(Icons.update),
                              onTap:(){
                        id = item[index]["key"];
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UpdateScreen(id : id)));
                    } , ) ,
                          //IconButton(icon: Icon(Icons.update,color: Colors.blue,), onPressed: UpdateScreen()),
                          InkWell(
                              child: Icon(Icons.delete,color: Colors.grey,),
                            onTap: (){
                              id = item[index]["key"];
                              dbRef.child(id).remove().then(
                                      (_){
                                        print("todo deletion successful");
                                        setState(() {
                                          item.removeAt(index);
                                        });
                                      });

                            },
                          ),
                        ],
                      ),

                    );
                  });
           }
            else{
              return Center(child: Container(child: CircularProgressIndicator()));
            }
          })

    );
  }
}










