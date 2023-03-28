import 'package:json_annotation/json_annotation.dart';

part 'conversation_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class ConversationModel {
  MessagesModel? user;
  MessagesModel? ice;
  
  ConversationModel({
    this.user,
    this.ice,

  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}

@JsonSerializable()
class MessagesModel {
  String content;
  String currentDateTime;

  MessagesModel({required this.content, required this.currentDateTime});

  factory MessagesModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesModelToJson(this);
}
