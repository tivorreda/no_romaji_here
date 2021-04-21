import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  ChoiceButton({required String text, required Function onPressed}) {
    this.text = text;
    this.onPressed = onPressed;
  }

  String? text;
  late Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45,
          border: Border.all(
              color: Colors.black45,
              width: 1.0,
              style: BorderStyle.solid
          )
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 45,
          ),
        ),
      ),
    );;
  }
}
