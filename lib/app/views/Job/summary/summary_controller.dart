import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/views/Job/my_jobs/jobs_model.dart';

class SummaryController extends GetxController {
  Summary summaryData = Summary(checks: []);
  Job jobData = Get.arguments;
  RxBool withOvertime = false.obs;
  bool isLoading = false;

  Rx<DateTimeRange> dateRange = DateTimeRange(
    start: DateTime.now().add(Duration(hours: 24 * -5)),
    end: DateTime.now(),
  ).obs;

  Future pickDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dateRange.value);

    if (newDateRange == null) return;
  }

  getSummary({DateTimeRange range, bool status}) async {
    isLoading = true;
    update();
    dateRange.value = range;
    try {
      var res = await http.get(GlobalVariables.api +
          "/worker/summary/getsummary/${jobData.id}?from=${range.start.toUtc()}&to=${range.end.toUtc()}&overtime=$status");
      switch (res.statusCode) {
        case 200:
          print('trajo la data bien');
          print(res.body);
          summaryData = Summary.fromJson(json.decode(res.body));
          isLoading = false;
          break;
        default:
          //summaryData = Summary.fromJson({});
          isLoading = false;
          break;
      }
      update();
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}

class Summary {
  Summary({
    this.id,
    this.total,
    this.hours,
    this.overtime,
    this.checks,
    this.paids,
    this.unpaids,
  });

  String id;
  String total;
  String hours;
  bool overtime;
  List<Check> checks;
  int paids;
  int unpaids;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        id: json["_id"],
        total: json["total"].toStringAsFixed(1),
        hours: json["hours"].toStringAsFixed(1),
        overtime: json["overtime"],
        checks: List<Check>.from(json["checks"].map((x) => Check.fromJson(x))),
        paids: json["paids"],
        unpaids: json["unpaids"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "total": total,
        "hours": hours,
        "overtime": overtime,
        "checks": List<dynamic>.from(checks.map((x) => x.toJson())),
        "paids": paids,
        "unpaids": unpaids,
      };
}

class Check {
  Check({
    this.date,
    this.hours,
    this.breakMinutes,
    this.paid,
    this.enable,
    this.id,
    this.checkIn,
    this.out,
    this.offset,
    this.salary,
    this.payment,
  });

  DateTime date;
  String hours;
  int breakMinutes;
  bool paid;
  bool enable;
  String id;
  DateTime checkIn;
  DateTime out;
  int offset;
  int salary;
  String payment;

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        date: DateTime.parse(json["date"]),
        hours: json["hours"].toStringAsFixed(1),
        breakMinutes: json["break_minutes"],
        paid: json["paid"],
        enable: json["enable"],
        id: json["_id"],
        checkIn: DateTime.parse(json["in"]),
        out: DateTime.parse(json["out"]),
        offset: json["offset"],
        salary: json["salary"],
        payment: json["payment"].toStringAsFixed(1),
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "hours": hours,
        "break_minutes": breakMinutes,
        "paid": paid,
        "enable": enable,
        "_id": id,
        "in": checkIn.toIso8601String(),
        "out": out.toIso8601String(),
        "offset": offset,
        "salary": salary,
        "payment": payment,
      };
}
