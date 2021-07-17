import 'dart:convert';

import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/models/conversations.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  Future<List<Conversation>> getConversations({String userName}) async {
    List<Conversation> listChats = [];
    try {
      var response = await http.get(Uri.parse(
          GlobalVariables.api + "/chat/getMyConversations/$userName"));
      listChats = conversationsFromJson(response.body);
      return listChats;
    } catch (e) {
      print("error get conversations: $e");
      return [];
    }
  }

  Future<Conversation> setNewConversation({Conversation conversation}) async {
    try {
      var response = await http.post(
          Uri.parse(GlobalVariables.api + "/chat/getMyConversations/"),
          body: conversation.toJson());

      return response.statusCode == 200
          ? Conversation.fromJson(json.decode(response.body))
          : Conversation.fromJson({});
    } catch (e) {
      print("error set new COnversation: $e");
      return Conversation.fromJson({});
    }
  }
}
