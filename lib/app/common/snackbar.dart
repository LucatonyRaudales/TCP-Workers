import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySnackBar{
  static void show({
    String title, 
    String message,
    Color backgroundColor,
    IconData icon
    }){
    Get.snackbar(
      '', 
      '',
      titleText: new Text(title, style: subTitleWhiteFontBold),
      messageText: new Text(message, style:bodyFontWhite, overflow: TextOverflow.visible),
      snackPosition: SnackPosition.TOP,
      borderRadius: 20.0,
      backgroundColor: backgroundColor,
      icon: Icon(icon, size: 25.sp, color: Colors.white,),
      margin: EdgeInsets.all(10.sp),
      );
  }
}