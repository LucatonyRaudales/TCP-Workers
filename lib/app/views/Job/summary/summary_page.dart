import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:tcp_workers/app/common/progressBar.dart';
import 'package:tcp_workers/app/views/Job/summary/summary_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  DateTimeRange range;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SummaryController>(
        init: SummaryController(),
        builder: (ctrl) => Scaffold(
            appBar: MyAppBar(
              title: 'Summary'.toUpperCase(),
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15),
                child: range == null
                    ? selectRange(ctrl: ctrl, context: context)
                    : showDataSummary(ctrl: ctrl))));
  }

  Widget showDataSummary({
    SummaryController ctrl,
  }) {
    if (ctrl.isLoading)
      return Center(
        child: MyProgressBar(),
      );
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.rocket, color: main_color, size: 35.sp),
        SizedBox(height: 10.sp),
        new Text(
          ctrl.jobData.name.toUpperCase(),
          style: titleFont,
        ),
        SizedBox(height: 25.sp),
        new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          new Column(
            children: [
              new Text((ctrl.summaryData.checks.length).toString(),
                  style: subTitleFontBold),
              SizedBox(height: 5.sp),
              new Text('Days', style: subTitleFont),
            ],
          ),
          new Column(
            children: [
              new Text(ctrl.summaryData.hours.toString(),
                  style: subTitleFontBold),
              SizedBox(height: 5.sp),
              new Text('Hours', style: subTitleFont),
            ],
          ),
          new Column(
            children: [
              new Text(ctrl.summaryData.total.toString() + '  USD',
                  style: subTitleFontBold),
              SizedBox(height: 5.sp),
              new Text('Payment', style: subTitleFont),
            ],
          ),
        ]),
        SizedBox(
          height: 12,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Column(
              children: [
                new Text(ctrl.summaryData.paids.toString(),
                    style: subTitleFontBold),
                SizedBox(height: 5.sp),
                new Text('Days paids', style: subTitleFont),
              ],
            ),
            new Column(
              children: [
                new Text(ctrl.summaryData.unpaids.toString(),
                    style: subTitleFontBold),
                SizedBox(height: 5.sp),
                new Text('Days unpaids', style: subTitleFont),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Obx(
          () => CheckboxListTile(
              value: ctrl.withOvertime.value,
              activeColor: Colors.green[300],
              checkColor: Colors.white,
              onChanged: (status) {
                ctrl.getSummary(range: range, status: status);
                ctrl.withOvertime.value = status;
              },
              title: new Text(
                "Overtime available",
                style: subTitleFont,
              ),
              subtitle: new Text(
                ctrl.withOvertime.value
                    ? "the paryment is calculated with overtime"
                    : "the payment is not calculated with overtime",
                style: bodyFont,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        SizedBox(height: 15.sp),
        Divider(thickness: 1.sp, indent: 25.sp, endIndent: 25.sp),
        SizedBox(height: 15.sp),
        listBuilder(checks: ctrl.summaryData.checks)
      ],
    ));
  }

  Widget listBuilder({List<Check> checks}) {
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: checks.length,
        itemBuilder: (context, index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: new Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color:
                        checks[index].paid ? Colors.green[100] : Colors.white,
                  ),
                  child: new ListTile(
                    leading: Text(
                        DateFormat.MMMd().format(checks[index].date).toString(),
                        style: subTitleFontBold),
                    title: Text(checks[index].hours.toString() + ' hours',
                        style: subTitleFontBold, textAlign: TextAlign.center),
                    subtitle: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Text(
                              DateFormat.jm()
                                  .format(checks[index].checkIn.toLocal())
                                  .toString(),
                              style: bodyFontBold,
                            ),
                            new Text(
                              'In',
                              style: bodyFont,
                            )
                          ],
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Text(
                              checks[index].breakMinutes.toString(),
                              style: bodyFontBold,
                            ),
                            new Text(
                              'Lunch mins.',
                              style: bodyFont,
                            )
                          ],
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Text(
                              DateFormat.jm()
                                  .format(checks[index].out.toLocal())
                                  .toString(),
                              style: bodyFontBold,
                            ),
                            new Text(
                              'Out',
                              style: bodyFont,
                            )
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          checks[index].payment.toString() + " USD",
                          style: subTitleFontBold,
                        ),
                        checks[index].paid
                            ? new Text('Salary (\$)',
                                style: bodyFont,
                                overflow: TextOverflow.ellipsis)
                            : SizedBox(),
                      ],
                    ),
                  )));
        });
  }

  Widget selectRange({SummaryController ctrl, BuildContext context}) {
    return Center(
        child:
            new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(CupertinoIcons.calendar, color: main_color, size: 55.sp),
      SizedBox(height: 10),
      new Text(
        'Start date - End date',
        style: titleFont,
      ),
      SizedBox(height: 10),
      ElevatedButton(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 25),
            child: new Text(
              'Select',
              style: titleWhiteFont,
            )),
        onPressed: () async {
          final a = await showDateRangePicker(
            context: Get.context,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5),
            initialDateRange: ctrl.dateRange.value ?? ctrl.dateRange.value,
          );
          if (a == null) return;
          setState(() {
            range = a;
          });
          ctrl.getSummary(range: range, status: ctrl.withOvertime.value);
        },
      ),
    ]));
  }
}
