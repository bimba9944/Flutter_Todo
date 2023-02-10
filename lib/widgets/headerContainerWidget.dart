import 'package:flutter/material.dart';

class HeaderContainerWidget extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;
  final Color iconColor;
  final String? title;
  final double contHeight;

  const HeaderContainerWidget(
      {super.key, required this.color1, required this.color2, required this.icon, required this.iconColor, this.title, required this.contHeight});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * contHeight,
      width: size.width * 1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(60),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1,
            color2
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
            size: 60,
          ),
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
