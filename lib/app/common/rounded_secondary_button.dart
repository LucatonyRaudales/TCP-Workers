import 'package:flutter/material.dart';
import 'package:tcp_workers/app/Style/text.dart';

class MySecondaryButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  MySecondaryButton({Key key, @required this.text, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return     Container(
    height: 30.0,
    child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color:  Colors.red,
                    style: BorderStyle.solid,
                    width: 1.0,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                text,
                style: bodyFontRed,
              ),
            ),
        ),
    ),
  );
  }
}