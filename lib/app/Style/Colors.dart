import 'package:flutter/material.dart';

const main_color = Colors.blueGrey;//Color.fromRGBO(50, 44, 91, 1);
const second_color = Colors.lightBlue;//Color.fromRGBO(166, 166, 227, 1);
const third_color = Color.fromRGBO(207, 208, 251, 1);
const quarter_color = Color.fromRGBO(252, 251, 254, 1);
MaterialColor mainColor = MaterialColor(0x322C5B, <int, Color>{50: Color(0xCFD0FB), 100: Color(0xA6A6E3) });
List<Color> listColor = [Colors.white, quarter_color];
Decoration background = BoxDecoration( gradient: LinearGradient( begin: Alignment.topRight, end: Alignment.bottomLeft, colors: listColor));
Widget appbarBackground = new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: listColor
            )
          )
        );

Decoration boxDecoration = BoxDecoration(
  gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: listColor
  )
);

Decoration commonContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, 2.0), //(x,y)
      blurRadius: 6.0,
    ),
  ],
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [third_color, quarter_color]),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25.0),
    bottomRight: Radius.circular(25.0)
  )
);