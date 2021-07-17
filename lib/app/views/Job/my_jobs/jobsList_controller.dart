import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../common/variables.dart';
import '../../signIn/user_model.dart';
import 'jobs_model.dart';

class JobsListCtrl extends GetxController{
  String status = Get.arguments;
  JobList jobList;
  final box = GetStorage();
  @override
  void onInit() {
    getJobsList(mystatus: status);
    super.onInit();
  }

  void getjobsAfterUpdate({String mystatus}){
    status = mystatus;
    getJobsList(mystatus: status);
  }
  
  Future getJobsList({String mystatus})async{
    print(status);
    try{
      var userDecode = json.decode(box.read('userData'));
      UserModel user = UserModel.fromJson(userDecode);
      var response = await http.get(Uri.parse(GlobalVariables.api + '/worker/getMyJobs/' + user.user.id + '?status=$mystatus'));
      print(response.body);
      switch(response.statusCode){
        case 200:
        var decode = json.decode(response.body);
        jobList = JobList.fromJson(decode);
        return update();
        break;
        default: 
        
        print(response.statusCode);
        return null;
        break;
      }
    }catch(err){
      print(err);
      return null;
    }
  }
}