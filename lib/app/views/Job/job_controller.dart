import 'dart:async';
import 'dart:convert';
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
import '../../Style/Colors.dart';
import '../../Style/text.dart';
import '../../common/textFormField.dart';
import '../../common/validations.dart';
import 'my_jobs/jobsList_controller.dart';
import 'my_jobs/jobs_model.dart';
import 'package:http/http.dart' as http;

class JobCtrl extends GetxController{
    Job jobData = Get.arguments;  
    String country;
    String state;
    String city;
  RxBool showButton = false.obs;
  DataPaid dataPaid = DataPaid();
  List list = ['hour', 'day'];
  String typeSelected;
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  PaymentRepository _paymentRepository = PaymentRepository();

  @override
  void onInit() {
    getTotalPaid();
    showButton.value = false;
    super.onInit();
  }

  void getTotalPaid(){
    _paymentRepository.getTotalPaidByJob(jobID: jobData.id)
      .then((value){
        dataPaid = value;
        update();
      });
  }

  void markAsFinished()async{
    try{
          var res = await http.put(GlobalVariables.api + '/worker/jobs/changeStatusJob',
          body:{
            'jobID' : jobData.id,
            'status' : 'finished'
          }
          );
          print(res.statusCode);
          switch (res.statusCode) {
            case 200:
              print('bien hecho');
              btnController.success();
              Timer(Duration(seconds: 2,), ()=> Get.to(HomePage(), transition: Transition.leftToRightWithFade));
            break;
            case 500:
              btnController.error();
              MySnackBar.show(title: 'Error!', message: res.body, backgroundColor: Colors.red, icon: CupertinoIcons.xmark_octagon_fill);
              Timer(Duration(seconds: 3,), ()=> btnController.reset());
            break;
            default:
              btnController.error();
              MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.xmark_octagon_fill);
              Timer(Duration(seconds: 3,), ()=> btnController.reset());
            break;
          }
    }catch(err){

    }
  }

    void selectCountry(String va){
    country = va;
  }
  void selectState(String va){
    state = va;
  }
  void selectCity(String va){
    city = va;
  }

  void updateJob()async{
    print(jobData.address.state);
    try{
      var response = await http.put(GlobalVariables.api + '/worker/jobs/updatejob',
      body: {
          'jobID': jobData.id,
          'name' : jobData.name,
          'type': jobData.type,
          'salary' : jobData.salary.toString(),
          'address' : json.encode({'state' : jobData.address.state, 'city':jobData.address.city}),
        });
      switch(response.statusCode){
        case 200:
          Get.put(JobsListCtrl());
          JobsListCtrl inst = Get.find();
          inst.getjobsAfterUpdate(mystatus: jobData.status);
          update();
          MySnackBar.show(title: 'Susccess', message: 'You are updated ${jobData.name} job', backgroundColor: Colors.green, icon: CupertinoIcons.check_mark_circled);
          btnController.success();
          Timer(Duration(seconds:3), ()=> Get.back());
        break;
        case 500:
          MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.xmark_circle);
          btnController.error();
          Timer(Duration(seconds: 3), ()=> btnController.reset());
        break;
        default:
        print('sepa mi ciela hermosa linda');
      }
    }catch(err){
      print(err);
    }
  }

  void editJobData(BuildContext context)async{
    showDialog(
        context: context,
    builder: (_) => new AlertDialog(
      title: new Text('Edit job data', style: subTitleFont, textAlign: TextAlign.center,),
      //shape: CircleBorder(BorderSide.circular(25)),
      content: _buildBottomSheet(context),
      actions: []
    ));
  }
 Widget _buildBottomSheet(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child:Form(
      key: _formKey,
      child: new ListView(
        children: [
        new SizedBox(height: 25.ssp),

        Input(
            hintText: "Name", 
            icon: CupertinoIcons.textformat, 
            initialValue: jobData.name,
            onChanged: (val)=> jobData.name = val,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateName,
          ),

          new SizedBox(height: 20.sp),

          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
            width: Get.width /3.6,
              padding: EdgeInsets.only(left: 5.sp),
              decoration: BoxDecoration(
                border: Border.all(color: main_color),
                borderRadius: BorderRadius.circular(5)
              ),
              child: DropdownButton(
                hint: new Text(typeSelected ?? 'Project by: ', style: bodyFont) ,
                dropdownColor: Colors.white,
                style: subTitleFont,
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 30.sp,
                value: typeSelected ?? jobData.type,
                onChanged: (val){
                  typeSelected = val;
                  jobData.type = val;
                  update();
                },
                items: list.map((e){
                  return DropdownMenuItem(
                    value: e,
                    child:  new Text(e),
                  );
                }).toList(),
              ),
            ),

            Input(
              width: Get.width /3,
              onChanged: (val)=> jobData.salary = int.tryParse(val),
              hintText: "Salary", 
              icon: CupertinoIcons.money_dollar, 
              initialValue: jobData.salary.toString(),
              textInputType: TextInputType.number,
              obscureText: false,
              validator: Validations.validateSalary,
            ),
          ],),

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
                onPressed:()=> _formKey.currentState.validate() ? updateJob() : btnController.stop(),
              ),

              new SizedBox(height: 20.sp),

              TextButton.icon(
                icon: Icon(Icons.arrow_back),
                onPressed:()=> Get.back(),
                label: new Text('cancel', style: bodyFont),
              )
          ],),
        ),
    );
  }
}