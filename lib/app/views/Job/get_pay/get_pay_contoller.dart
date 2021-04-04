import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Job/my_jobs/jobs_model.dart';
import 'package:tcp_workers/app/views/Job/get_pay/get_pay_model.dart';

class GetPayCtrl extends GetxController {
  RxBool showButton = false.obs;
  List<RxBool> statePay = [];
  Job jobData = Get.arguments;
  DaystoPay daystoPay = new DaystoPay();

  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();

  @override
  Future<void> onInit() async {
    showButton.value = false;
    daystoPay.days = [];
    await loadingDaytoPay();

    super.onInit();
  }

  Future<void> loadingDaytoPay() async {
    try {
      // var res = await http.get(
      //   GlobalVariables.api + '/worker/payment/getUnpaidDays/' + jobData.id,
      // );
      var res = await http.get(
        GlobalVariables.api +
            '/worker/payment/getUnpaidDays/605ba4a072ab360015591d29',
      );
      print(res.statusCode);
      switch (res.statusCode) {
        case 200:
          print('bien hecho');
          daystoPay = DaystoPay.fromJson(jsonDecode(res.body)[0]);
          daystoPay.days.map((e) => {statePay.add(false.obs)}).toList();
          update(["daysList"]);
          btnController.success();
          break;
        case 500:
          btnController.error();
          MySnackBar.show(
              title: 'Error!',
              message: res.body,
              backgroundColor: Colors.red,
              icon: CupertinoIcons.xmark_octagon_fill);
          Timer(
              Duration(
                seconds: 3,
              ),
              () => btnController.reset());
          break;
        default:
          btnController.error();
          MySnackBar.show(
              title: 'Error!',
              message: 'There was an unexpected error, please try again',
              backgroundColor: Colors.red,
              icon: CupertinoIcons.xmark_octagon_fill);
          Timer(
              Duration(
                seconds: 3,
              ),
              () => btnController.reset());
          break;
      }
    } catch (err) {}
  }
}
