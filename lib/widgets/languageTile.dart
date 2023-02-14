import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final String languageName;
  final String imagePath;
  final Function translateFunction;
  final bool isSelected;

  const LanguageTile({super.key, required this.imagePath, required this.languageName, required this.translateFunction, required this.isSelected});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => translateFunction(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: !isSelected?const Color.fromRGBO(255, 255, 204, 0.7):const Color.fromRGBO(255, 204, 153, 1),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                languageName,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: Image(image: AssetImage(imagePath),fit: BoxFit.cover,width: 100,height: 100,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
