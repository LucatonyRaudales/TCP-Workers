import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/models/conversations.dart';
import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/models/messages.dart';
import 'package:tcp_workers/app/views/signIn/user_model.dart';

class ChatRepository {
    RxBool isLoading = false.obs;
  Future<List<Conversation>> getConversations({UserModel user}) async {
    List<Conversation> listChats = [];

    try {
      var response = await http.get(Uri.parse(GlobalVariables.api +
          "/chat/getMyConversations/${user.user.nickName}"));
      listChats = conversationsFromJson(response.body);
      return listChats;
    } catch (e) {
      print("error get conversations: $e");
      return [];
    }
  }

  Future<Conversation> setNewConversation(
      {String userToContact, UserModel currentUser}) async {
    Conversation _conversation = Conversation();
    try {
      var response = await http.post(
          Uri.parse(GlobalVariables.api + "/chat/setNewConversation/"),
          body: {
            "findUser": "Bnito",
            "currentUser": currentUser.user.nickName,
            "createAt": DateTime.now().millisecondsSinceEpoch.toString()
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        _conversation = Conversation.fromJson(json.decode(response.body));
      }
      return _conversation;
    } catch (e) {
      print("error set new Conversation: $e");
      return Conversation.fromJson({});
    }
  }

  Future<List<Message>> getMessages({String chatID}) async {
    try {
      var response = await http
          .get(Uri.parse(GlobalVariables.api + '/chat/GetMessages/$chatID'));
      return messagesFromJson(response.body);
    } catch (e) {
      print("error getMessages repo: $e");
      return messagesFromJson("");
    }
  }
}
