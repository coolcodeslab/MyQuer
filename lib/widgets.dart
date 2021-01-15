import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      //height 40
//      height: height * 0.06,
      //width 300
//      width: width * 0.8,
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
    );
  }
}
