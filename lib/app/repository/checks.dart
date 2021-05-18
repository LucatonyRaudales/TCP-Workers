import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/variables.dart';

class ChecksRepository {
  Future<bool> disableCheck({String jobID, String checkID})async{
    try {
      var res = await http.put(GlobalVariables.api + "/worker/check/disableCheck",
      body: {
        "jobID": jobID,
        "checkID": checkID
      }
    );

    return res.statusCode == 200;
    } catch (e) {
      print("error disableCheck: $e");
      return false;
    }
  }
}