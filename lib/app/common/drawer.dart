import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/views/Job/add_new_job/newJob_page.dart';
import 'package:tcp_workers/app/views/signIn/login_controller.dart';
import 'package:tcp_workers/app/views/splash_screen/splash_page.dart';

import '../Style/Colors.dart';
import '../views/User/edit_user/edit_user_page.dart';

class DrawerItem extends StatefulWidget {
  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  final box = GetStorage();
  User user;
  void getUserData() async {
    try {
      user = User.fromJson(json.decode(box.read('userData')));
    } catch (e) {}
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void logout() async {
    await box.erase();
    Get.off(SplashPage(), transition: Transition.fade);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 5.ssp, vertical: 25.ssp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Column(
                children: [
                  new Text('main menu'.toUpperCase(),
                      style: titleFont, textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  new Container(
                      height: 90.sp,
                      width: 100.sp,
                      child: new CircleAvatar(
                          backgroundColor: main_color,
                          child: Icon(
                            CupertinoIcons.person_crop_circle,
                            size: 55.sp, color: Colors.white
                            )
                        )
                    ),

                  SizedBox(height: 15),
                  new Text(
                    user.user.firstName + ' ' + user.user.lastName,
                    style: titleFont,
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 3.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Get.to(EditUserPage(),
                                  transition: Transition.zoom)
                              .then((value) => {
                                    if (value == 'ok')
                                      {
                                        Get.off(SplashPage(),
                                            transition: Transition.fade)
                                      }
                                  }),
                          icon: Icon(Icons.edit),
                          color: main_color,
                          splashRadius: 20.sp,
                        ),
                        Text(" Editar")
                      ],
                    ),
                  )
                ],
              ),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _drawerItem(
                        function: () => Get.back(),
                        icon: CupertinoIcons.home,
                        text: 'Home'),
                    SizedBox(height: 15.ssp),
                    _drawerItem(
                        function: () => Get.to(NewJobPage()),
                        icon: CupertinoIcons.cloud_sun_fill,
                        text: 'New job'),
                  ]),
              _drawerItem(
                  function: () => logout(),
                  icon: CupertinoIcons.escape,
                  text: 'Logout'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem({
    Function function,
    IconData icon,
    String text,
  }) {
    return new InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10.ssp)),
      splashColor: second_color,
      onTap: function,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.ssp, horizontal: 10.ssp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.ssp)),
              border: Border.all(width: 1.ssp, color: main_color)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Icon(
                icon,
                size: 15.ssp,
                color: main_color,
              ),
              new Text(text, style: subTitleFont),
              new Icon(
                Icons.arrow_forward_ios_rounded,
                color: main_color,
              )
            ],
          )),
    );
  }
}
