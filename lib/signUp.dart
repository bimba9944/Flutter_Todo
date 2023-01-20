import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepOrangeAccent,
                  Colors.orangeAccent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.ac_unit,
                  color: Colors.white,
                  size: 60,
                ),
                Text(
                  "Todo Manager",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: Form(
              child: Material(
                elevation: 50,
                shadowColor: Colors.grey,
                child: TextFormField(
                  decoration:  InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, width: 0,
                      ),
                      borderRadius: BorderRadius.circular((28.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
