import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/models/checks.dart';

class PaymentRepository{
  ListCheck checks = ListCheck();

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

  Future<bool> registerPay({List<String> checkDays})async{
    String url = GlobalVariables.api + "/worker/payment/getUnpaidDays";
    var res = await http.put(url, body: checkDays);
  }
}