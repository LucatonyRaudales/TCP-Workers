import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/views/splash_screen/splash_page.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  MyAppBar({
    this.actions
  });

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: new Column(children:[
        Text('Techno contructions +'.toUpperCase(), style: subTitleWhiteFont),
        Text('by Techno Business Plus', style:minimalWhiteFont)
      ]),
      centerTitle: true,
      backgroundColor: main_color,
      primary: true,
      actions: actions ?? null
    );
  }
}