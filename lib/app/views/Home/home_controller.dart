import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';

class HomeCtrl extends GetxController{
  @override
  void onInit() {
    print('welcome to home');
    super.onInit();
  }

  void getDataHomePage()async{
    try{
      var response = await http.get(GlobalVariables.api +'');
      switch (response.statusCode) {
        case 200:
          print('abuebp');
        break;
        default:
          print('asaber que pedo');
      }
    }catch(err){
      print(err);
    }
  }
}