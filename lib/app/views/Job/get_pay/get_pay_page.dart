import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/views/Job/get_pay/get_pay_contoller.dart';

class GetPayPage extends StatefulWidget {
  @override
  _GetPayPageState createState() => _GetPayPageState();
}

class _GetPayPageState extends State<GetPayPage> {
  @override
  Widget build(BuildContext context) {
    var statusPay = [];
    return GetBuilder<GetPayCtrl>(
      id: "daysList",
      init: GetPayCtrl(),
      builder: (ctrl) => Scaffold(
        appBar: MyAppBar(),
        body: ListView.builder(
          itemCount: ctrl.daystoPay.days.length,
          itemBuilder: (BuildContext context, int i) {
            statusPay.add(false);
            return TextButton(
              onPressed: () {
                setState(() {
                  statusPay[i] = true;
                });
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: main_color,
                    radius: 25,
                    child: new Icon(
                      statusPay[i]
                          ? CupertinoIcons.checkmark_alt_circle
                          : CupertinoIcons.circle,
                      color: Colors.white,
                    ),
                  ),
                  title: Column(
                    children: [
                      new Text(
                        ctrl.daystoPay.days[i].date.toString(),
                        style: subTitleFontBold,
                      ),
                      new Text(
                        ctrl.daystoPay.days[i].date.toString(),
                        style: subTitleFontBold,
                      ),
                    ],
                  ),
                  subtitle: new Text(
                    'By: job.type',
                    style: subTitleFontBold,
                  ),
                  trailing: new Icon(CupertinoIcons.chevron_right),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
