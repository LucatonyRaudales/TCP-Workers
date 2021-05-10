import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/models/checks.dart';
import 'package:tcp_workers/app/models/data_paid.dart';

class PaymentRepository{
  ListCheck checks = ListCheck();

  Future<DataPaid> getTotalPaidByJob({String jobID})async{
   DataPaid data = DataPaid();
    String url = GlobalVariables.api + "/worker/payment/getTotalPaid/$jobID";
    try{
      var res = await http.get(url);
        var decode = json.decode(res.body);
      if(decode.isNotEmpty){
        data = DataPaid.fromJson(decode[0]);
      }else{
        data = DataPaid.fromJson({});
      }
      return data;
    }catch(e){
      print('Error get total paid by job: $e');
      return DataPaid.fromJson({});
    }
  }
  Future<ListCheck> getUnpaidDays({String jobID})async{
    String url = GlobalVariables.api + "/worker/payment/getUnpaidDays/$jobID";
    try{
      var res = await http.get(url);
      if(res.statusCode == 200){
        var decode = json.decode(res.body);
        checks = ListCheck.fromJson(decode[0]);
      }
      return checks;
    }catch(e){
      print('error get ubnpaid days: $e');
      return checks;
    }
  }

  Future<bool> registerPay({List<String> checkDays, String jobID})async{
    String url = GlobalVariables.api + "/worker/payment/payDays";
    var res = await http.put(url, body: {
      "jobID": jobID,
      "listDays": json.encode(checkDays)
    });
    return res.statusCode == 200;
  }
}