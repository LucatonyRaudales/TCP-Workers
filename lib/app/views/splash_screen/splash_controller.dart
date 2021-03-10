import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';
import 'package:tcp_workers/app/views/signIn/Login_page.dart';

class SplashCtrl extends GetxController{
  final box = GetStorage();

  @override
  void onInit() {
    verifyIsLogin();
    super.onInit();
  }

  void verifyIsLogin()async{
    if(box.hasData('userData')){
      Timer(Duration(seconds: 3), ()=> Get.off(()=> HomePage(), transition: Transition.zoom));
    }else{
      await box.erase();
      Timer(Duration(seconds: 3), ()=> Get.off(()=> SignInPage(), transition: Transition.zoom));
    }
  }
}