// To parse this JSON data, do
//
//     final chatMessageResponse = chatMessageResponseFromJson(jsonString);

import 'dart:convert';

List<ChatMessageResponse> chatMessageResponseFromJson(String str) =>
    List<ChatMessageResponse>.from(
        json.decode(str).map((x) => ChatMessageResponse.fromJson(x)));

String chatMessageResponseToJson(List<ChatMessageResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMessageResponse {
  ChatMessageResponse(
      {this.recipientId,
      this.image,
      this.sender,
      this.text,
      this.buttons,
      this.custom});

  String? recipientId;
  String? image;
  String? sender;
  String? text;
  List<Button>? buttons;
  Custom? custom;

  ChatMessageResponse copyWith({
    String? recipientId,
    String? image,
    String? sender,
    String? text,
    List<Button>? buttons,
    Custom? custom,
  }) =>
      ChatMessageResponse(
          recipientId: recipientId ?? this.recipientId,
          image: image ?? this.image,
          sender: sender ?? this.sender,
          text: text ?? this.text,
          buttons: buttons ?? this.buttons,
          custom: custom ?? this.custom);

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      ChatMessageResponse(
        recipientId: json["recipient_id"],
        image: json["image"] == null ? null : json["image"],
        sender: json["sender"],
        text: json["text"] == null ? null : json["text"],
        buttons: json["buttons"] == null
            ? null
            : List<Button>.from(json["buttons"].map((x) => Button.fromJson(x))),
        custom: json["custom"] == null ? null : Custom.fromJson(json["custom"]),
      );

  Map<String, dynamic> toJson() => {
        "recipient_id": recipientId,
        "image": image == null ? null : image,
        "sender": sender,
        "text": text == null ? null : text,
        "buttons":
            buttons == null ? null : buttons?.map((x) => x.toJson()).toList(),
        "custom": custom == null ? null : custom?.toJson(),
      };
}

class Button {
  Button({
    this.title,
    this.payload,
  });

  String? title;
  String? payload;

  Button copyWith({
    String? title,
    String? payload,
  }) =>
      Button(
        title: title ?? this.title,
        payload: payload ?? this.payload,
      );

  factory Button.fromJson(Map<String, dynamic> json) => Button(
        title: json["title"],
        payload: json["payload"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "payload": payload,
      };
}

class Custom {
  Custom({
    this.youtubeId,
  });

  final String? youtubeId;

  Custom copyWith({
    String? youtubeId,
  }) =>
      Custom(
        youtubeId: youtubeId ?? this.youtubeId,
      );

  factory Custom.fromJson(Map<String, dynamic> json) => Custom(
        youtubeId: json["youtubeId"] == null ? null : json["youtubeId"],
      );

  Map<String, dynamic> toJson() => {
        "youtubeId": youtubeId == null ? null : youtubeId,
      };
}
