import 'package:flutter/material.dart';
import 'package:tcp_workers/app/Style/text.dart';

class MyDialog{
  void show({ BuildContext context,  String title,  Widget content, List<Widget> actions}){
    showDialog(
        context: context,
    builder: (_) => new AlertDialog(
          title: new Text(title, style: subTitleFont,  textAlign: TextAlign.center,),
          //shape: CircleBorder(BorderSide.circular(25)),
          content: content,
          actions: actions
        ));
  }
}