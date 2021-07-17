import 'dart:convert';

List<Conversation> conversationsFromJson(String str) => List<Conversation>.from(json.decode(str).map((x) => Conversation.fromJson(x)));
String conversationsToJson(List<Conversation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Conversation {
    Conversation({
        this.id,
        this.participants,
        this.createAt,
        this.enable,
        this.deletedAt,
        this.deletedBy,
    });

    String id;
    List<Participant> participants;
    int createAt;
    bool enable;
    int deletedAt;
    String deletedBy;

    factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["_id"],
        participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
        createAt: json["create_at"],
        enable: json["enable"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "create_at": createAt,
        "enable": enable,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
    };
}

class Participant {
    Participant({
        this.id,
        this.username,
    });

    String id;
    String username;

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["_id"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
    };
}
