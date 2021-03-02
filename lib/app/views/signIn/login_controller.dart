import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';

class LoginCtrl extends GetxController{
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  @override
  void onInit() {
    print('holis');
    super.onInit();
  }

  void loginWithEmail()async{
    Timer(Duration(seconds: 2), ()=>{
      btnController.success(),
      Timer(Duration(seconds:1), ()=>{
      Get.off(HomePage(), transition: Transition.zoom)
      })
    });
  }
}