import 'package:json_annotation/json_annotation.dart';
import 'package:revolt_client/src/models/user/user.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {

  Message(
      {required this.id,
      required this.nonce,
      required this.channel,
      required this.author,
      required this.content,
      required this.user,});

  factory Message.fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'nonce')
  String nonce;
  @JsonKey(name: 'channel')
  String channel;
  @JsonKey(name: 'author')
  String author;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'user')
  RelationUser? user;

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
