import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';
import '../signIn/user_model.dart';

class HomeCtrl {
  final box = GetStorage();

  Future<dynamic> getDataHomePage() async {
    try {
      var decode = json.decode(box.read('userData'));
      UserModel user = UserModel.fromJson(decode);
      var response = await http
          .get(GlobalVariables.api + '/worker/dashboardData/' + user.user.id);
      return json.decode(response.body);
    } catch (err) {
      print('Errorase + $err');
    }
  }
}
