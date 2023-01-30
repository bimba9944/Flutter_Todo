import 'package:flutter/material.dart';
import 'package:todo/helpers/colorHelper.dart';


class InputItems extends StatelessWidget {
  final IconData inputIcon;
  final String inputHint;


  InputItems(this.inputIcon, this.inputHint);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow:[
          BoxShadow(
            spreadRadius: -50,
            color: ColorHelper.input.inputShadow,
            blurRadius: 10,
            offset: Offset(10, 20),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Form(
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              inputIcon,
              color: ColorHelper.input.inputIcon,
            ),
            errorStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            hintText: inputHint,
            hintStyle:  TextStyle(fontSize: 16, color: ColorHelper.input.inputHint),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: ColorHelper.input.fillColor,
          ),
        ),
      ),
    );
  }
}
