import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';

class CheckingCtrl extends GetxController{
  @override
  void onInit() {
    print('checking controller initializated!');
    super.onInit();
  }

  void setCheck(){
    Timer(Duration(seconds: 2), (){
    print('checado mi papasito');
    Get.off(HomePage());
    });
  }
}