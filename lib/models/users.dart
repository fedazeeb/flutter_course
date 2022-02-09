import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Users {
  String username;
  String email;
  String password;
  int age;
  CollectionReference users;

  Users(
      {required this.username,
      required this.email,
      required this.users,
        required this.age,
      required this.password});

    Future<void> addUser() async {
    // Call the user's CollectionReference to add a new user
    return await users
        .add({
          'username': username, // John Doe
          'email': email, // Stokes and Sons
          'age': 42 // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser() async {
    // Call the user's CollectionReference to add a new user
    return await users
        .add({
      'username': username, // John Doe
      'email': email, // Stokes and Sons
      'age': 42 // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
