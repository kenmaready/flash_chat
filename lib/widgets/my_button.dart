import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;

  const MyButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.buttonColor = Colors.lightBlueAccent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
            elevation: 5.0,
            color: buttonColor,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              onPressed: onPressed,
              minWidth: 200.0,
              height: 42.0,
              child: Text(text),
            )));
  }
}
