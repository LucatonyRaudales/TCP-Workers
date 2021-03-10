import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/views/splash_screen/splash_page.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final box = GetStorage();

  @override
  Size get preferredSize => const Size.fromHeight(55);

  void logout()async{
    await box.erase();
    Get.off(SplashPage(), transition: Transition.fade);
  }

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
      actions:[
        new IconButton(
          icon: Icon(CupertinoIcons.square_arrow_right), onPressed: ()=> ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: main_color,
            content: const Text('Sure you want to log out?', ),
            action: SnackBarAction(onPressed: ()=> logout(), label: 'Yes!', textColor: Colors.white,),
            ),
          ))
      ]
    );
  }
}