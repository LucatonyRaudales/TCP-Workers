import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/Style/text.dart';

class HomeCard extends StatelessWidget {
  final String text;
  final String number;
  final IconData icon;
  final Function function;
  HomeCard({
    @required this.text, 
    @required this.number, 
    @required this.icon,
    @required this.function
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: Get.height / 3,
        padding: EdgeInsets.only(top:15.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(-0.5, 2.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
        ),
        child: new Column(children: [

          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
            Spacer(flex: 3,),

            new Text(number, style:  TextStyle(fontSize:20.sp, color: second_color ),),
            Spacer(),
            new Text(text, style: titleFont),
            Spacer(flex: 4),
          ]),

          new Divider(
            color: second_color, 
            thickness: 2.sp,
            endIndent: 105.sp
            ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal:10),
            child: new Icon(
              icon, 
              color: main_color,
              size: 100.sp,
            ),
          )
        ],),
      )
    );
  }
}