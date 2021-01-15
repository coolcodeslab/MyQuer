import 'package:flutter/material.dart';
import 'constants.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.controller,
    this.errorText,
  });
  final String hintText;
  final Function onChanged;
  final bool obscureText;
  final TextEditingController controller;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: kTextBoxColor,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          style: TextStyle(
            color: kTextFieldTextColor,
          ),
          decoration: InputDecoration(
            errorText: errorText,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActionButtonWidget extends StatelessWidget {
  ActionButtonWidget(
      {this.title, this.passedWidth, this.onTap, this.passedHeight = 30});
  final String title;
  final double passedWidth;
  final Function onTap;
  final double passedHeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          //takes the content height and multiplies it by the sent factor
          height: passedHeight,
          //takes the content width and multiplies it by the sent factor
          width: passedWidth,
          decoration: BoxDecoration(
            color: kMainColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: kButtonTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _scaffoldKey.currentState.openEndDrawer(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: height * 0.045,
        width: width * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Center(
          child: Icon(
            Icons.menu,
            color: kMainColor,
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  CustomDrawer({this.onTapLogOut, this.onTapQrCodes});

  final Function onTapQrCodes;
  final Function onTapLogOut;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      width: height * 0.15,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.045,
          ),

          //log out
          CustomDrawerItem(
            onTap: onTapLogOut,
            title: 'log out',
          )
        ],
      ),
    );
  }
}

class CustomDrawerItem extends StatelessWidget {
  CustomDrawerItem({this.onTap, this.title});
  final Function onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height * 0.045,
        decoration: BoxDecoration(
          color: kMainColor.withOpacity(0.1),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: kMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      ),
    );
  }
}
