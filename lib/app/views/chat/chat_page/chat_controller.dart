import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tcp_workers/app/repository/chat.dart';
import 'package:tcp_workers/app/views/signIn/user_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatController extends GetxController
    with StateMixin<RxList<types.Message>> {
  TextEditingController mensajeController = TextEditingController();
  final show = false.obs;
  FocusNode focusNode = FocusNode();
  final sendButton = false.obs;
  RxList<types.Message> messages = RxList<types.Message>();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Socket socket;
  UserModel user = UserModel();
  String chatID = "";
  types.User userChat;

  @override
  void onInit() {
    user = Get.arguments["user"];
    userChat = types.User(id: user.user.id, firstName: user.user.nickName);
    chatID = Get.arguments["chatID"];
    print("iniciado $chatID");
    connect();
    super.onInit();
  }

  void getMessages() async {
    var value = await ChatRepository().getMessages(chatID: chatID);
    messages.value = value;
    update();
    change(messages, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void connect() async {
    getMessages();
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
       /* var message = types.Message.fromJson(data);
        messages.insert(0, message);
        update();
        
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 1,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
        textController.clear();*/
      });
      socket.onDisconnect((_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print("error: $e");
    }
  }

  void sendMessage(types.TextMessage message) {
    print("chatID para alla: $chatID");
    /*
    pr;
    print("user: ${user.user.nickName}");
    print("chatID: $chatID");*/
    socket.emit('chat:message', message.toJson());
    // mensajeController.text = '';
  }

  //////aqui
  ///
  List<types.Message> _messages = [];

  void _addMessage(types.Message message) {
    messages.insert(0, message);
    update();
  }

  void handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: Get.context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      final message = types.FileMessage(
        author: userChat,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: chatID,
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path ?? '',
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: userChat,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: chatID,
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      messages[index] = updatedMessage;
    });
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      roomId: chatID,
      author: userChat,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: chatID,
      text: message.text,
    );
    print(textMessage.toJson());
    sendMessage(textMessage);
    _addMessage(textMessage);
  }
}
