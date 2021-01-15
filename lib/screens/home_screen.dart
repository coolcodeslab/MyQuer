import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_qr_code/constants.dart';
import 'package:my_qr_code/screens/login_screen.dart';
import 'package:my_qr_code/screens/qr_screen.dart';
import 'package:my_qr_code/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String data = 'hello';
  final _auth = FirebaseAuth.instance;
  bool error = false;

  TextEditingController qrTextEditingController = TextEditingController();
  void onChangedData(n) {
    data = n;
    setState(() {
      error = false;
    });
  }

  void onTapGenerate() {
    setState(() {
      qrTextEditingController.text.isEmpty ? error = true : error = false;
    });
    if (qrTextEditingController.text.isEmpty) {
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRScreen(
            data: data,
          ),
        ),
      );
    }

    qrTextEditingController.clear();
  }

  void onTapLogout() {
    _auth.signOut();
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.15,
                ),
                Text(
                  'Generate Your\n    QR code',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                  ),
                ),
                SizedBox(
                  height: height * 0.15,
                ),
                TextFieldWidget(
                  hintText: 'Enter link',
                  onChanged: onChangedData,
                  controller: qrTextEditingController,
                  errorText: error ? kLinkErrorText : null,
                ),
                ActionButtonWidget(
                  title: 'Generate',
                  passedWidth: width * 0.69,
                  onTap: onTapGenerate,
                ),
                SizedBox(
                  height: height * 0.3,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ActionButtonWidget(
                    title: 'log out',
                    passedWidth: width * 0.24,
                    onTap: onTapLogout,
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
