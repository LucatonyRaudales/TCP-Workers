import 'dart:async';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/models/data_paid.dart';
import 'package:tcp_workers/app/repository/payment.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';
import 'package:tcp_workers/app/views/splash_screen/splash_page.dart';
import '../../Style/Colors.dart';
import '../../Style/text.dart';
import '../../common/textFormField.dart';
import '../../common/validations.dart';
import 'my_jobs/jobList_page.dart';
import 'my_jobs/jobsList_controller.dart';
import 'my_jobs/jobs_model.dart';
import 'package:http/http.dart' as http;

class JobCtrl extends GetxController {
  Job jobData = Job();
  String country;
  String state;
  String city;
  RxBool showButton = false.obs;
  DataPaid dataPaid = DataPaid();
  List list = ['hour', 'day'];
  String typeSelected;
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();
  PaymentRepository _paymentRepository = PaymentRepository();
  RxBool overtime = false.obs,
      typeJobIsByday = false.obs,
      typeJobIsByHour = false.obs;

  @override
  void onInit() {
    jobData = Get.arguments;
    print(jobData.name);
    getTotalPaid(jobID: jobData.id);
    showButton.value = false;
    super.onInit();
  }

  void getTotalPaid({String jobID}) {
    overtime.value = jobData.overtime;
    typeJobIsByHour.value = jobData.type == "hour" ? true : false;
    typeJobIsByday.value = jobData.type == "day" ? true : false;
    _paymentRepository.getTotalPaidByJob(jobID: jobID).then((value) {
      dataPaid = value;
      update();
    });
  }

  void markAsFinished() async {
    try {
      var res = await http.put(
          GlobalVariables.api + '/worker/jobs/changeStatusJob',
          body: {'jobID': jobData.id, 'status': 'finished'});
      print(res.statusCode);
      switch (res.statusCode) {
        case 200:
          print('bien hecho');
          btnController.success();
          showButton.value = false;
          Get.put(JobsListCtrl());
          JobsListCtrl jobsListCtrl = Get.find();
          jobsListCtrl.getJobsList();
          Timer(
              Duration(
                seconds: 2,
              ),
              () => Get.to(() => SplashPage(),
                  transition: Transition.leftToRightWithFade));
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

  void selectCountry(String va) {
    country = va;
  }

  void selectState(String va) {
    state = va;
  }

  void selectCity(String va) {
    city = va;
  }

  void updateJob() async {
    jobData.overtime = overtime.value;
    print(jobData.address.state);
    if (typeJobIsByday.value) {
      jobData.type = "day";
    } else if (typeJobIsByHour.value) {
      jobData.type = "hour";
    } else {
      btnController.error();
      MySnackBar.show(
          title: 'Error!',
          message: 'You have not selected a type of work',
          backgroundColor: Colors.red,
          icon: CupertinoIcons.multiply_circle);
      Timer(Duration(seconds: 3), () => btnController.reset());
      return null;
    }
    try {
      var response =
          await http.put(GlobalVariables.api + '/worker/jobs/updatejob', body: {
        'jobID': jobData.id,
        'name': jobData.name,
        'type': jobData.type,
        "overtime": jobData.overtime.toString(),
        'salary': jobData.salary.toString(),
        'address': json.encode(
            {'state': jobData.address.state, 'city': jobData.address.city}),
      });
      switch (response.statusCode) {
        case 200:
          Get.put(JobsListCtrl());
          print(response.body);
          JobsListCtrl inst = Get.find();
          inst.getjobsAfterUpdate(mystatus: jobData.status);
          update();
          MySnackBar.show(
              title: 'Susccess',
              message: 'You are updated ${jobData.name} job',
              backgroundColor: Colors.green,
              icon: CupertinoIcons.check_mark_circled);
          btnController.success();
          Timer(Duration(seconds: 3), () => Get.back());
          break;

        case 401:
          btnController.stop();
          MySnackBar.show(
              title: "Whoops I'm sorry",
              message: 'you have reached the limit of jobs with the ${jobData.type} type',
              backgroundColor: Colors.orange,
              icon: CupertinoIcons.exclamationmark_circle);
         break;
        case 500:
          MySnackBar.show(
              title: 'Error!',
              message: 'There was an unexpected error, please try again',
              backgroundColor: Colors.red,
              icon: CupertinoIcons.xmark_circle);
          btnController.error();
          Timer(Duration(seconds: 3), () => btnController.reset());
          break;
        default:
          print('sepa mi ciela hermosa linda');
      }
    } catch (err) {
      print(err);
    }
  }

  void editJobData(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text(
              'Edit job data',
              style: subTitleFont,
              textAlign: TextAlign.center,
            ),
            //shape: CircleBorder(BorderSide.circular(25)),
            content: _buildBottomSheet(context),
            actions: []));
  }

  Widget _buildBottomSheet(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Container(
      height: 600,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: new ListView(
          children: [
            new SizedBox(height: 25.ssp),
            Input(
              hintText: "Name",
              icon: CupertinoIcons.textformat,
              initialValue: jobData.name,
              onChanged: (val) => jobData.name = val,
              textInputType: TextInputType.text,
              obscureText: false,
              validator: Validations.validateName,
            ),
            new SizedBox(height: 15.sp),
            Obx(() => CheckboxListTile(
                  subtitle: Text("payment is based on days worked",
                      style: bodyFontBold),
                  title: Text("By day", style: subTitleFontBold),
                  secondary: Icon(CupertinoIcons.sun_dust, color: main_color),
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: typeJobIsByday.value,
                  onChanged: (bool value) {
                    typeJobIsByHour.value = false;
                    typeJobIsByday.value = value;
                    overtime.value = false;
                  },
                )),
            new SizedBox(height: 15.sp),
            Obx(() => CheckboxListTile(
                  subtitle:
                      Text("pay is based on hours worked", style: bodyFontBold),
                  title: Text("By hour", style: subTitleFontBold),
                  secondary: Icon(CupertinoIcons.clock, color: main_color),
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: typeJobIsByHour.value,
                  onChanged: (bool value) {
                    typeJobIsByHour.value = value;
                    typeJobIsByday.value = false;
                    overtime.value = false;
                  },
                )),
            new SizedBox(height: 15.sp),
            Obx(
              () => typeJobIsByHour.value
                  ? FadeInDown(
                      child: CheckboxListTile(
                      title: Text("Overtime", style: subTitleFontBold),
                      subtitle: Text("Your company offers overtime?",
                          style: bodyFontBold),
                      secondary: Icon(Icons.money),
                      controlAffinity: ListTileControlAffinity.platform,
                      value: overtime.value,
                      onChanged: (bool value) => overtime.value = value,
                    ))
                  : Container(),
            ),
            new SizedBox(height: 20.sp),
            CSCPicker(
              onCountryChanged: (value) {
                selectCountry(value);
              },

              ///triggers once state selected in dropdown
              onStateChanged: (value) {
                selectState(value);
              },

              ///triggers once city selected in dropdown
              onCityChanged: (value) {
                selectCity(value);
              },
            ),
            new SizedBox(height: 40.sp),
            RoundedLoadingButton(
              color: main_color,
              errorColor: Colors.red,
              successColor: Colors.green,
              child: Text('Save', style: TextStyle(color: Colors.white)),
              controller: btnController,
              onPressed: () => _formKey.currentState.validate()
                  ? updateJob()
                  : btnController.stop(),
            ),
            new SizedBox(height: 20.sp),
            TextButton.icon(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
              label: new Text('cancel', style: bodyFont),
            )
          ],
        ),
      ),
    );
  }
}
