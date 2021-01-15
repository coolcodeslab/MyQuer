import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String data = 'hello';
  final _auth = FirebaseAuth.instance;
  bool error = false;

  TextEditingController qrTextEditingController = TextEditingController();

  AnimationController controller;
  Animation animation;

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

  void onChangedData(n) {
    data = n;
    setState(() {
      error = false;
    });
  }

//checks if value is empty and pushes to qr screen
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

  void logOut() {
    _auth.signOut();
    Navigator.pushNamed(context, LoginScreen.id);
  }

  void onTapLogout(BuildContext context) {
    //Cupertino Dialog Box
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: new Text("Log out of MyQuer?"),
        content: new Text("Don't leave us!"),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Yes"),
            onPressed: () {
              logOut();
            },
          ),
          CupertinoDialogAction(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,

        //Drawer
        endDrawer: CustomDrawer(
          onTapLogOut: () {
            onTapLogout(context);
          },
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),

                //Drawer Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DrawerButton(
                      scaffoldKey: _scaffoldKey,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.15,
                ),

                //Generate Qr code message
                Text(
                  'Generate Your\n    QR code ${(animation.value * 100).round()}%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),

                //Link textField
                TextFieldWidget(
                  hintText: 'Enter link',
                  onChanged: onChangedData,
                  controller: qrTextEditingController,
                  errorText: error ? kLinkErrorText : null,
                ),

                //Generate button
                ActionButtonWidget(
                  title: 'Generate',
                  passedWidth: width * 0.69,
                  onTap: onTapGenerate,
                ),
                SizedBox(
                  height: height * 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
