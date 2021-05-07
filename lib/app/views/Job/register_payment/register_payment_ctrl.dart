import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tcp_workers/app/models/checks.dart';
import 'package:tcp_workers/app/repository/payment.dart';

class RegisterPaymentCtrl extends GetxController{
  PaymentRepository _paymentRepository = PaymentRepository();
  ListCheck listCheck = ListCheck();
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
    
  }
}