import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_qr_code/screens/home_screen.dart';
import 'package:my_qr_code/widgets.dart';
import 'package:my_qr_code/constants.dart';

class SignupScreen extends StatefulWidget {
  static const id = 'signup screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String email;
  String password;
  bool showSpinner = false;
  bool validate = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onTapSignin() async {
    setState(() {
      showSpinner = true;
      emailController.text.isEmpty ? validate = true : validate = false;
      passwordController.text.isEmpty ? validate = true : validate = false;
    });
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = _auth.currentUser.uid;
      await _fireStore.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'uid': uid,
      });
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

  void onChangedEmail(n) {
    setState(() {
      validate = false;
    });
    email = n;
  }

  void onChangedPassword(n) {
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
                  height: height * 0.02,
                ),
                BackButton(
                  color: kMainColor,
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
                  hintText: 'password',
                  onChanged: onChangedPassword,
                  obscureText: true,
                  errorText: validate ? 'Invalid value' : null,
                  controller: passwordController,
                ),
                ActionButtonWidget(
                  onTap: onTapSignin,
                  title: 'Sign up',
                  passedWidth: width * 0.24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
