import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tcp_workers/app/common/variables.dart';

class SocketIOController extends GetxController {
  /*Socket socket;

  @override
  void onReady() {
    connect();
    super.onInit();
  }

  void connect() async {
    try {
      print("hola3");
      socket = io(
          GlobalVariables.api,
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .enableForceNewConnection() // necessary because otherwise it would reuse old connection

              .setQuery(<String, dynamic>{'chatID': "chatID"})
              .build());
      socket.connect();
      socket.onConnect((socket) {
        print('connect');
      });
    } catch (e) {
      print("error: $e");
    }
  }*/

  Socket socket;

  void connectToServer() {
    try {
      // Configure socket transports must be sepecified
      socket = io(
          GlobalVariables.api,
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .enableForceNewConnection() // necessary because otherwise it would reuse old connection
              .build());

      // Connect to websocket
      socket.connect();
      socket.onConnect((data) {
        print("connect: $data");
        socket.emit("join room", {"username": "username", "roomName": "room"});
      });

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('location', handleLocationListen);
      socket.on('typing', handleTyping);
      socket.on('chat:message', handleMessage);
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  // Send Location to Server
  sendLocation(Map<String, dynamic> data) {
    socket.emit("location", data);
  }

  // Listen to Location updates of connected usersfrom server
  handleLocationListen(Map<String, dynamic> data) async {
    print(data);
  }

  // Send update of user's typing status
  sendTyping(bool typing) {
    socket.emit("typing", {
      "id": socket.id,
      "typing": typing,
    });
  }

  // Listen to update of typing status from connected users
  void handleTyping(Map<String, dynamic> data) {
    print(data);
  }

  // Send a Message to the server
  sendMessage(TextMessage message) {
    print("enviando mensaje");
    socket.emit('chat:message', message.toJson());
  }

  // Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {
    print("mensaje recibido");
    print(data);
  }
}
