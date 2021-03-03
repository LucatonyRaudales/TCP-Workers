import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(
            horizontal: 5.ssp,
            vertical: 25.ssp
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[ 

            new Text('Techno construction plus'.toUpperCase(), style: titleFont, textAlign: TextAlign.center),
            
            new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            _drawerItem(
              function: ()=> Get.back(),
              icon:  CupertinoIcons.home,
              text: 'Home'
            ),

            SizedBox(height: 15.ssp),
            new Text('New Job'.toUpperCase(), style: subTitleFont),
            
            SizedBox(height: 15.ssp),
            _drawerItem(
              function: ()=> print('new user'),
              icon:  CupertinoIcons.time_solid,
              text: 'For hour'
            ),
            SizedBox(height: 15.ssp),
            _drawerItem(
              function: ()=> print('new Customer'),
              icon:  CupertinoIcons.cloud_sun_fill,
              text: 'For day'
            ),

          ]
        ),
            _drawerItem(
              function: ()=> print('logout'),
              icon:  CupertinoIcons.escape,
              text: 'Logout'
            ),
          ]
          )
          )
      )
    );
  }


  Widget _drawerItem({
    Function function,
    IconData icon,
    String text,
  }){
    return new InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10.ssp)),
          splashColor: second_color,
          onTap: function,
          child:Container(
            padding: EdgeInsets.symmetric(vertical: 5.ssp, horizontal:10.ssp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.ssp)),
              border: Border.all(width: 1.ssp, color: main_color)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                new Icon(icon, size: 15.ssp, color: main_color,),
                new Text(text, style: subTitleFont),
                new Icon(Icons.arrow_forward_ios_rounded, color: main_color,)
              ],)
          ),
        );
  }
}