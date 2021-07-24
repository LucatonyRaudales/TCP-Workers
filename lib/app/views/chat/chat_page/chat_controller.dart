/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tcp_workers/app/models/messages.dart';
import 'package:tcp_workers/app/repository/chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tcp_workers/app/views/signIn/user_model.dart';

class ChatController extends GetxController {
  List<Message> messages = [];
  ScrollController scrollController = new ScrollController();
  Socket socket;
  UserModel user = UserModel();
  String chatID = "";

  @override
  void onInit() {
    user = Get.arguments["user"];
    chatID = Get.arguments["chatID"];
    print("iniciado");
    connectToServer();
    super.onInit();
  }

  void getMessages() async {
    ChatRepository().getMessages().then((value) => print(value));
  }

  void connectToServer() async {
    // Dart client
    print("user: ${user.user.nickName}");
    print("chatID: $chatID");
    print("hola2");
    try {
      print("hola3");
      socket = io(
          'http://192.168.1.7:3001',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .enableForceNewConnection() // necessary because otherwise it would reuse old connection

              .setQuery(<String, dynamic>{'chatID': chatID})
              .build());
      socket.connect();
      socket.onConnect((socket) {
        print('connect');
      });
      print(socket.connected);
      socket.on('chat:message', (data) {
        print(data);
        messages.add(Message.fromJson(data));
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 1,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
      socket.onDisconnect((_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print("error: $e");
    }
  }

  void sendMessage() {/*
    print("Viene");
    print("user: ${user.user.nickName}");
    print("chatID: $chatID");*/
    socket.emit('chat:message', {
      'chatID': "60f8b0b90b009d2d5ceb702c",
      'senderID': "etsarodeada",
      'message': "data"
    });
    // mensajeController.text = '';
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tcp_workers/app/models/messages.dart';
import 'package:tcp_workers/app/repository/chat.dart';
import 'package:tcp_workers/app/views/signIn/user_model.dart';

class ChatController extends GetxController {
  final show = false.obs;
  FocusNode focusNode = FocusNode();
  final sendButton = false.obs;
  RxList<Message> messages = RxList<Message>();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Socket socket;
  UserModel user = UserModel();
  String chatID = "";

  @override
  void onInit() {
    user = Get.arguments["user"];
    chatID = Get.arguments["chatID"];
    print("iniciado");
    super.onInit();
  }

  void getMessages() async {
    ChatRepository().getMessages().then((value) => print(value));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void connect() {
    // Dart client
    print("user: ${user.user.nickName}");
    print("chatID: $chatID");
    print("hola2");
    try {
      print("hola3");
      socket = io(
          'http://192.168.1.7:3001',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .enableForceNewConnection() // necessary because otherwise it would reuse old connection

              .setQuery(<String, dynamic>{'chatID': chatID})
              .build());
      socket.connect();
      socket.onConnect((socket) {
        print('connect');
      });
      print(socket.connected);
      socket.on('chat:message', (data) {
        print(data);
        messages.add(Message.fromJson(data));
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 1,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
      socket.onDisconnect((_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print("error: $e");
    }
  }

  void sendMessage() {
    /*
    print("Viene");
    print("user: ${user.user.nickName}");
    print("chatID: $chatID");*/
    socket.emit('chat:message', {
      'chatID': "60f8b0b90b009d2d5ceb702c",
      'senderID': "etsarodeada",
      'message': "data"
    });
    // mensajeController.text = '';
  }
}
