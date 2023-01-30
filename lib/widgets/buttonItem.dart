import 'package:flutter/material.dart';
import 'package:todo/helpers/colorHelper.dart';

class ButtonItem extends StatelessWidget {
  final String buttonTxt;

  ButtonItem(this.buttonTxt);

  @override
  Widget build(BuildContext context) {
    void changePage(){
      Navigator.pushNamed(context, '/PageAfterLogIn');
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      height: 45.0,
      child: ElevatedButton(
        onPressed: changePage,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Ink(
          decoration: BoxDecoration(
              gradient:LinearGradient(
                colors: [ColorHelper.button.buttonColor1,ColorHelper.button.buttonColor2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              buttonTxt,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: ColorHelper.button.buttonText, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
