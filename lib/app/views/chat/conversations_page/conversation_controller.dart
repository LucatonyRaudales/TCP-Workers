import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcp_workers/app/common/dialog.dart';
import 'package:tcp_workers/app/common/validations.dart';
import 'package:tcp_workers/app/models/conversations.dart';
import 'package:tcp_workers/app/repository/chat.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/views/signIn/user_model.dart';

class ConversationController extends GetxController {
  List<Conversation> conversations = [];
  ChatRepository _repository = ChatRepository();
  final box = GetStorage();
  UserModel user;

  RxBool findUser = false.obs;

  @override
  void onInit() {
    getMyConversations();
    super.onInit();
  }

  void newConversation({Conversation conversation, BuildContext context}) {
    String userName = "";
    final _formkey = GlobalKey<FormState>();

    MyDialog().show(
        context: context,
        title: 'New conversation',
        content: Form(
          key: _formkey,
          child: TextFormField(
            onChanged: (val) => userName = val,
            validator: Validations.validateNickName,
            decoration: InputDecoration(
              hintText: "@Nickname",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade400,
                size: 20,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100)),
            ),
          ),
        ),
        actions: [
          findUser.value
              ? CircularProgressIndicator()
              : ElevatedButton.icon(
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      this.findUserAndCreateChat(userToContact: userName);
                    }
                  },
                  icon: Icon(Icons.search),
                  label: Text("Find"))
        ]);
  }

  void findUserAndCreateChat({String userToContact}) {
    try {
      _repository.setNewConversation(userToContact: userToContact);
    } catch (e) {
      print("error findUserAndCreateChat: $e");
    }
  }

  void getMyConversations() {
    var decode = json.decode(box.read('userData'));
    user = UserModel.fromJson(decode);
    _repository.getConversations(user: user).then((value) {
      print(value);
      conversations = value;
      update();
    });
  }
}
