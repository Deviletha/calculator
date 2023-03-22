import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
  final color;
  final textColor;
  final String bottonText;
  final buttonTapped;

  MyBotton({this.color, this.textColor, required this.bottonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                bottonText,
                style: TextStyle(color: textColor, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
