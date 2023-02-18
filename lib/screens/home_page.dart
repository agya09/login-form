import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Future<User?> readUser() async {
      final docUser =
          FirebaseFirestore.instance.collection('users').doc('my-id');
      final snapshot = await docUser.get();

      if (snapshot.exists) {
        final user = User.fromJson(snapshot.data()!);
        return user;
      } else {
        return null;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: FutureBuilder(
        future: readUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return user == null
                ? Center(child: Text("User not found"))
                : buildUser(user);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // decoration: const BoxDecoration(
        //   color: Colors.white,
        // ),
        // child: SingleChildScrollView(
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 300, left: 20, right: 20),
        //     child: Column(
        //       children: <Widget>[
        //         const Text(
        //           "Welcome to the Home Screen ",
        //           style: TextStyle(color: Colors.black),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  buildUser(User user) => ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
      );
}

class User {
  String id;
  final String name;
  final String email;
  final DateTime created_at;
  final int age;

  User({
    this.id = '',
    required this.name,
    required this.email,
    required this.created_at,
    required this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': created_at,
      'age': age,
    };
  }

  static fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        created_at: json['created_at'],
        age: json['age'],
      );
}
