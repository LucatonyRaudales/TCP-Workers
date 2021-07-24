import 'dart:convert';

List<Message> messagesFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messagesToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    this.id,
    this.sentAt,
    this.conversationId,
    this.sender,
    this.content,
  });

  String id;
  int sentAt;
  String conversationId;
  String sender;
  String content;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        sentAt: json["sent_at"],
        conversationId: json["conversationID"],
        sender: json["sender"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sent_at": sentAt,
        "conversationID": conversationId,
        "sender": sender,
        "content": content,
      };
}
