import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/models/checks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/views/Job/register_payment/register_payment_ctrl.dart';

class RegisterPaymentPage extends StatefulWidget {
  @override
  _RegisterPaymentPageState createState() => _RegisterPaymentPageState();
}

class _RegisterPaymentPageState extends State<RegisterPaymentPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Register payment', style: titleFont)
      ),
      body: GetBuilder<RegisterPaymentCtrl>(
        init: RegisterPaymentCtrl(),
        builder: (_ctrl){
          if(_ctrl.listCheck.days.isNotEmpty)
          return Container(
            child:  ListView.separated(
              itemCount: _ctrl.listCheck.days.length,
              separatorBuilder:  (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return _card(checkDay: _ctrl.listCheck.days[index], index: index);
              })
          );
          return CircularProgressIndicator();
        }),
    );
  }

  Widget _card({Day checkDay, int index}){
    return Container(
    height: 100.sp,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: new CheckboxListTile(
        activeColor: Colors.pink[300],
        value: checkDay.isCheck,
        onChanged: (bool val) {
          setState(() {
              checkDay.isCheck = val;
            });
        },
        dense: true,
        secondary:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(DateFormat.d().format(checkDay.date).toString(), style: subTitleFontBold),
          Text(DateFormat.MMM().format(checkDay.date).toString(), style: subTitleFont, textAlign: TextAlign.center),
        ],),
        title: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text(checkDay.hours.toString()  + ' hours  -  ' + checkDay.payment.toString() + ' USD', style: subTitleFontBold, textAlign: TextAlign.center),

          new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          new Text(DateFormat.jm().format(checkDay.dayIn.toLocal()).toString(), style: bodyFontBold,),
          new Text('In', style: bodyFont,)
        ],),

        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          new Text(checkDay.breakMinutes.toString(), style: bodyFontBold,),
          new Text('Lunch mins.', style: bodyFont,)
        ],),

        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          new Text(DateFormat.jm().format(checkDay.out.toLocal()).toString(), style: bodyFontBold,),
          new Text('Out', style: bodyFont,)
        ],),
        ],)
        ],),
      )
    )
  );
  }
}