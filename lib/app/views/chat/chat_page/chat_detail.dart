import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'chat_controller.dart';

class ChatDetail extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: controller.obx((state) => Chat(
        messages: controller.messages,
        onAttachmentPressed: controller.handleAtachmentPressed,
        onMessageTap: controller.handleMessageTap,
        onPreviewDataFetched: controller.handlePreviewDataFetched,
        onSendPressed: controller.handleSendPressed,
        user: controller.userChat,
      ),)
    );
  }

}

/*
class ChatDetail extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: new Text("App chat")),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Expanded(
                child: controller.obx((state) => ListView.separated(
                      controller: controller.scrollController,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10.0,
                        );
                      },
                      reverse: false,
                      shrinkWrap: true,
                      itemCount: controller.messages.length,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemBuilder: (BuildContext context, int index) {
                        chat.Message m = controller.messages[index];
                        if (m.sender == controller.user.user.nickName)
                          return _buildMessageRow(m,
                              current: true, context: context);
                        return _buildMessageRow(m,
                            current: false, context: context);
                      },
                    ))),
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.mensajeController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.sendMessage(controller.mensajeController.text),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Row _buildMessageRow(chat.Message data,
      {bool current, BuildContext context}) {
    return Row(
      mainAxisAlignment:
          current ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: current ? 30.0 : 20.0,
        ),
        Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color:
                  current ? Theme.of(context).primaryColor : Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              data.content,
              style: TextStyle(
                  color: current ? Colors.white : Colors.black, fontSize: 18),
            )),
        SizedBox(
          width: current ? 20.0 : 30.0,
        )
      ],
    );
  }
}

/*
todo lo grs debe de ser color del logo= azul
en la parte de empresa, hay que mostrar más información sobre la empresa,
la imagen de perfil que sea vea grande(ahorita no)
cambiar al color corporativo
categoría de usuario se debe cargar en el panel y mostrar en la app...
agregar tipos de usuario en el panel => y que se carguen en la app al momento de registrar y de editar mis datos.
si voy a mis cotizaciones y no tengo clientes o productos entonces hay que mostrarle un mensaje al usuario que debe agregar cliente y(o) producto.

si agrego un producto a la cotización, que se agregue correctamente y que se quite de la lista de productos a agregar...
creación de la liga.


crud en el panel para el tipo de usuario...
*/

class Data {
  Data({
    this.receiverID,
    this.senderID,
    this.message,
  });

  String receiverID;
  String senderID;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        receiverID: json["receiverID"],
        senderID: json["senderID"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "senderID": senderID,
        "receiverID": receiverID,
        "message": message,
      };
}
*/