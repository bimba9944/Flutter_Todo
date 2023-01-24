import 'package:flutter/material.dart';

class InputItems extends StatelessWidget {
  //const InputItems({Key? key}) : super(key: key);

  final IconData? inputIcon;
  final String inputHint;

  InputItems(this.inputIcon, this.inputHint);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            spreadRadius: -50,
            color: Colors.grey,
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
              color: Colors.grey,
            ),
            errorStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            prefixIconColor: Colors.grey,
            hintText: inputHint,
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
