import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';

class EditUserCtrl extends GetxController{
  @override
  void onInit() {
    print('user level');
    super.onInit();
  }

  void updateUser()async{
    try {
      var response = await http.put(GlobalVariables.api + '',
        body: {
          ' ' : ''
        }
      );
    } catch (e) {
      print(e);
    }
  }
}