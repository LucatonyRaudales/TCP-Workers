import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final String title;
  MyAppBar({this.actions, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: new Column(children: [
          Text(title ?? 'Workers'.toUpperCase(), style: subTitleWhiteFont),
          Text(title != null ? 'Workers' : 'by Techno Business Plus',
              style: minimalWhiteFont)
        ]),
        centerTitle: true,
        backgroundColor: main_color,
        primary: true,
        actions: actions ?? null);
  }
}
