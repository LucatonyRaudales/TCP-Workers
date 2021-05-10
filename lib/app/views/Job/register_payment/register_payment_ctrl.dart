import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/models/checks.dart';
import 'package:tcp_workers/app/repository/payment.dart';

import '../job_controller.dart';

class RegisterPaymentCtrl extends GetxController{
  PaymentRepository _paymentRepository = PaymentRepository();
  ListCheck listCheck = ListCheck();
  List<String> daysToRegisterPay = [];
  String jobID;

  @override
  void onInit() {
    jobID = Get.arguments;
    print('Welcome to register payent');
    getDaysNotPayment();
    super.onInit();
  }

  void getDaysNotPayment()async{
    ListCheck val = await _paymentRepository.getUnpaidDays(jobID: jobID);
    listCheck = val;
    return update();
  }

  void registerPay()async{
    listCheck.days.forEach((element){
      if(element.isCheck) daysToRegisterPay.add(element.id);
    });
    if(daysToRegisterPay.isEmpty){
      return MySnackBar.show(title: 'List is empty!', message: 'you should select one or more days before posting the payment', backgroundColor: Colors.red, icon: CupertinoIcons.xmark_circle);
    }
    _paymentRepository.registerPay(checkDays:daysToRegisterPay, jobID: jobID)
    .then((val){
      daysToRegisterPay.clear();
      if(val){
        Get.put(JobCtrl());
        JobCtrl inst = Get.find();
        inst.getTotalPaid();
        MySnackBar.show(title: 'Susccess', message: 'you was registered the payment', backgroundColor: Colors.green, icon: CupertinoIcons.check_mark_circled);
          Timer(Duration(seconds: 3), ()=> Get.back());
      }else{
          MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.xmark_circle);
      }
    });
  }
}