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
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
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
