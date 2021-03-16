import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/views/Job/my_jobs/jobs_model.dart';

class SummaryController extends GetxController{
  Summary summaryData;
  Job jobData = Get.arguments;
  RxBool isLoading = false.obs;
  Rx<DateTimeRange> dateRange = DateTimeRange(
      start: DateTime.now().add(Duration(hours: 24 * -5)),
      end: DateTime.now(),
    ).obs;


  Future pickDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange.value
    );

    if (newDateRange == null) return;
  }

  Future<Summary> getSummary({DateTimeRange range})async{
    isLoading.value = true;
    dateRange.value = range;
    try{
      var res = await http.get(GlobalVariables.api + "/worker/summary/getsummary/${jobData.id}?from=${range.start.toUtc()}&to=${range.end.toUtc()}");
      switch (res.statusCode) {
        case 200:
          print('trajo la data bien');
          print(res.body);
          return Summary.fromJson(json.decode(res.body));
        break;
        default:
        print('hubo un pedo my friend');
        return null;
      }
    }catch(e){
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
        this.checks,
    });

    String id;
    double total;
    double hours;
    List<Check> checks;

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        id: json["_id"],
        total: json["total"].toDouble(),
        hours: json["hours"].toDouble(),
        checks: List<Check>.from(json["checks"].map((x) => Check.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "total": total,
        "hours": hours,
        "checks": List<dynamic>.from(checks.map((x) => x.toJson())),
    };
}

class Check {
    Check({
        this.hours,
        this.breakMinutes,
        this.id,
        this.date,
        this.checkIn,
        this.out,
        this.offset,
        this.salary,
        this.payment,
    });

    double hours;
    int breakMinutes;
    String id;
    DateTime date;
    DateTime checkIn;
    DateTime out;
    int offset;
    int salary;
    double payment;

    factory Check.fromJson(Map<String, dynamic> json) => Check(
        hours: json["hours"].toDouble(),
        breakMinutes: json["break_minutes"],
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        checkIn: DateTime.parse(json["in"]),
        out: DateTime.parse(json["out"]),
        offset: json["offset"],
        salary: json["salary"],
        payment: json["payment"] == null ? null : json["payment"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "hours": hours,
        "break_minutes": breakMinutes,
        "_id": id,
        "date": date.toIso8601String(),
        "in": checkIn.toIso8601String(),
        "out": out.toIso8601String(),
        "offset": offset,
        "salary": salary,
        "payment": payment == null ? null : payment,
    };
}
