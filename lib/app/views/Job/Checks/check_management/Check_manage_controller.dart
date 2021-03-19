import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Job/my_jobs/jobs_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:time_range_picker/time_range_picker.dart';

class CheckManagementController extends GetxController {
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  RxBool fetchingData = true.obs;
  final box = GetStorage();
  DateTime date;
  Rx<DateTime> dat = DateTime(2000,1,1).obs;
  Job jobData = Get.arguments;
  Check checkData;
  DateTime dateToday;

  void selectDate()async{var time = DateTime.now();
    if(date == new DateTime(time.year, time.month, time.day, 0, 0, 0, 0, 0)){
      MySnackBar.show(title: 'Invalid date', message: 'You must select previous dates', backgroundColor: Colors.redAccent, icon: CupertinoIcons.xmark_circle);
      dat.value = DateTime(2000,1,1);
    }else{
      checkDate();
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;
    dat.value = newDate; 
    date = newDate;
    selectDate();
  }

  void calculateHoursWorked({TimeRange time}){
    if(time.endTime == null || time.startTime == null) return null;
    checkData.hours = (toDouble(time.endTime) - toDouble(time.startTime)) - checkData.breakMinutes/60;
    checkData.payment = checkData.hours * jobData.salary;
  }

  double toDouble(TimeOfDay time)=> time.hour + time.minute/60.0;

  void checkDate()async{
    print(date.toIso8601String());
    try{
      var response = await http.get(GlobalVariables.api + '/worker/check/getCheckByDate/${jobData.id}?date=${date.toUtc()}');
      switch (response.statusCode) {
        case 200:
        CheckManagement check= CheckManagement.fromJson(json.decode(response.body));
        if(check.check.length > 0){
          fetchingData.value = false;
          checkData = check.check[0];
        }else{
          MySnackBar.show(title: 'The selected day was not checked', message: 'You can do it in the check-up session', backgroundColor: Colors.orange, icon: CupertinoIcons.info);
          Timer(Duration(seconds:3), ()=>Get.back());
        } 
          break;
        default:
        print('hubo algo mi perro');
      }
    }catch(err){
      print('errorcito');
      print(err);
    }
    update();
  }

  void updateCheck()async{
    if(checkData.hours < 0.1){ 
      btnController.reset();
      return MySnackBar.show(title: 'Hours worked is 0 or less', message: 'Select the time of entry - exit and lunch time of today', backgroundColor: Colors.redAccent, icon: CupertinoIcons.xmark_circle);
    }
    print('aqui pasa mi amorcita');
    try{
      var response = await http.put(GlobalVariables.api + '/worker/check/updateCheck',
      body: {
        'jobID' : jobData.id,
        'checkID' : checkData.id,
        'in' : checkData.checkIn.toString(),
        'out' : checkData.out.toString(),
        'hours' : checkData.hours.toString(),
        'break_minutes' : checkData.breakMinutes.toString(),
        'payment' : checkData.payment.toString(),
        'date' : checkData.date.toString()
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          btnController.success();
          MySnackBar.show(title: 'successful check', message: 'you have successfully checked ${DateFormat.yMMMMEEEEd().format(checkData.date)}', backgroundColor: Colors.green, icon: CupertinoIcons.checkmark_alt_circle);
          Timer(Duration(seconds: 3), ()=> Get.back());
          break;
        case 500:
          btnController.error();
          MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.person_crop_circle_badge_xmark);
          Timer(Duration(seconds: 2), ()=> btnController.reset());
        break;
        default:
        printError(info:'error mi terosa');
      }
    }catch(err){
      print(err);
    }
  }
}

String welcomeToJson(CheckManagement data) => json.encode(data.toJson());

class CheckManagement {
    CheckManagement({
        this.id,
        this.check,
    });

    String id;
    List<Check> check;

    factory CheckManagement.fromJson(Map<String, dynamic> json) => CheckManagement(
        id: json["_id"],
        check: List<Check>.from(json["check"].map((x) => Check.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "check": List<dynamic>.from(check.map((x) => x.toJson())),
    };
}

class Check {
    Check({
        this.date,
        this.hours,
        this.breakMinutes,
        this.id,
        this.checkIn,
        this.out,
        this.offset,
        this.salary,
        this.payment,
    });

    DateTime date;
    double hours;
    int breakMinutes;
    String id;
    DateTime checkIn;
    DateTime out;
    int offset;
    int salary;
    double payment;

    factory Check.fromJson(Map<String, dynamic> json) => Check(
        date: DateTime.parse(json["date"]),
        hours: json["hours"],
        breakMinutes: json["break_minutes"],
        id: json["_id"],
        checkIn: DateTime.parse(json["in"]),
        out: DateTime.parse(json["out"]),
        offset: json["offset"],
        salary: json["salary"],
        payment: json["payment"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "hours": hours,
        "break_minutes": breakMinutes,
        "_id": id,
        "in": checkIn.toIso8601String(),
        "out": out.toIso8601String(),
        "offset": offset,
        "salary": salary,
        "payment": payment,
    };
}
