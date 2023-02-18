import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../reuseable_widgets/reuseable_widget.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future createUser({required String name, required String email}) async {
      final docUser = FirebaseFirestore.instance.collection('users').doc();

      final user = User(
        id: docUser.id,
        name: name,
        email: email,
        created_at: DateTime.now(),
        age: 21,
      );
      final json = user.toJson();

      //create document and write data to firebase
      await docUser.set(json);
    }

    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 29, 232, 255),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 300, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  reusebleTextField("Enter Username", Icons.person_outline,
                      false, _usernameTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reusebleTextField("Enter email", Icons.person_outline, false,
                      _emailTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reusebleTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 30,
                  ),
                  submitButton(context, false, () {
                    final name = _usernameTextController.text;
                    final email = _emailTextController.text;

                    createUser(name: name, email: email);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  }),
                ],
              ),
            ),
          )),
    );
  }
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

    User fromJson(Map<String, dynamic> json) => User(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          created_at: json['created_at'],
          age: json['age'],
        );
  }
}
