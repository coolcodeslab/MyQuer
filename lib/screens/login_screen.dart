import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_qr_code/constants.dart';
import 'package:my_qr_code/screens/home_screen.dart';
import 'package:my_qr_code/screens/signup_screen.dart';
import 'package:my_qr_code/widgets.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String email;
  String password;
  bool validate = false;

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  AnimationController controller;
  Animation animation;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    controller.forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
    super.initState();
  }

  void onTapLogin() async {
    setState(() {
      showSpinner = true;
      emailController.text.isEmpty ? validate = true : validate = false;
      passwordController.text.isEmpty ? validate = true : validate = false;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamed(context, HomeScreen.id);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      showSpinner = false;
    });
  }

  void onTapSignin() {
    Navigator.pushNamed(context, SignupScreen.id);
  }

  void onChangedEmail(n) {
    //when the value is changed the error text goes away
    setState(() {
      validate = false;
    });
    email = n;
  }

  void onChangedPassword(n) {
    //when the value is changed the error text goes away
    setState(() {
      validate = false;
    });
    password = n;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: Theme(
        data: ThemeData(accentColor: kMainColor),
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  'MyQuer',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                TextFieldWidget(
                  hintText: 'email',
                  onChanged: onChangedEmail,
                  errorText: validate ? 'Invalid value' : null,
                  controller: emailController,
                ),
                TextFieldWidget(
                  onChanged: onChangedPassword,
                  hintText: 'password',
                  obscureText: true,
                  errorText: validate ? 'Invalid value' : null,
                  controller: passwordController,
                ),
                ActionButtonWidget(
                  title: 'Log in',
                  passedWidth: width * 0.24,
                  onTap: onTapLogin,
                ),
                SizedBox(
                  height: height * 0.25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ActionButtonWidget(
                    onTap: onTapSignin,
                    title: 'Sign up',
                    passedWidth: width * 0.69,
                    passedHeight: height * 0.052,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
