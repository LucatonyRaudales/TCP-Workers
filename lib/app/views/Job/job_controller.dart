import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'my_jobs/jobs_model.dart';

class JobCtrl extends GetxController{
  Job jobData = Get.arguments;

  @override
  void onInit() {
    print('job controller');
    print(jobData.name);
    super.onInit();
  }

  void getJobData()async{
    try{

    }catch(err){
      print(err);
    }
  }
}