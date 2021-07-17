import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tcp_workers/app/models/conversations.dart';
import 'package:tcp_workers/app/repository/chat.dart';

class ConversationController extends GetxController {
  List<Conversation> conversations = [];
  ChatRepository _repository = ChatRepository();

  @override
  void onInit() {
    getMyConversations();
    super.onInit();
  }

  void newConversation({Conversation conversation}) {
    try {} catch (e) {
      print("error: $e");
    }
  }

  void getMyConversations() {
    _repository.getConversations().then((value) {
      print(value);
      conversations = value;
      update();
    });
  }
}
