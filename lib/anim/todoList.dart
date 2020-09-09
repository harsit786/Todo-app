import 'package:firebase_database/firebase_database.dart';

class Todo {
  String key;
  String subject;
  bool completed;
  String userId;

  Todo({this.subject, this.userId, this.completed});
  Todo.map(dynamic obj) {
    this.userId = obj['id'];
    this.subject = obj['title'];
    this.completed = obj['description'];
  }

  Todo.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        userId = snapshot.value["id"],
        subject = snapshot.value["todo"],
        completed = snapshot.value["completed"];

  toJson() {
    return {
      "id": userId,
      "todo": subject,
      "completed": completed,
    };
  }

}