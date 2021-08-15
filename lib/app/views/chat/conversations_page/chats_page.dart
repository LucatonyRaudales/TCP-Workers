import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:tcp_workers/app/views/chat/chat_page/chat_bindings.dart';
import 'package:tcp_workers/app/views/chat/chat_page/chat_detail.dart';

import 'conversation_controller.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationController>(
        init: ConversationController(),
        builder: (_ctrl) => Scaffold(
              appBar: MyAppBar(
                title: "Conversations",
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () => _ctrl.newConversation(context: context),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "New".toUpperCase(),
                            style: subTitleWhiteFont,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: TextField(
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100)),
                        ),
                      ),
                    ),
                    Obx(() {
                      return ListView.builder(
                        itemCount: _ctrl.conversations.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 16),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(() => ChatDetail(),
                                binding: ChatBinding(),
                                arguments: {
                                  "chatID": _ctrl.conversations[index].id,
                                  "user": _ctrl.user
                                }),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 10, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          child: Icon(Icons.person),
                                          maxRadius: 15,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(_ctrl.conversations[index]
                                                    .users[0].username
                                                    .toString(), style: subTitleFontBold),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  DateFormat.yMEd()
                                                      .format(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              _ctrl
                                                                  .conversations[
                                                                      index]
                                                                  .createAt))
                                                      .toString(),
                                                  style: bodyFont,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 15, color: main_color,)
                                  /*
                                  Text(
                                    _ctrl.conversations[index].createAt
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: true
                                            ? Colors.pink
                                            : Colors.grey.shade500),
                                  ),*/
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })
                  ],
                ),
              ),
            ));
  }
}
