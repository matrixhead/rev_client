import 'dart:convert';

import 'package:revolt_client/src/api_wrapper/helpers.dart';
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/http_client.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/user/user.dart';

Future<CurrentUser> fetchSelf(
  RevHttpClient clientConfig,
) async {
  try {
    final response = await clientConfig.get(path: '/users/@me');
    return CurrentUser.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<CurrentUser> completeOnboarding(
    RevHttpClient clientConfig, String username,) async {
  final body = json.encode({
    'username': username,
  });
  try {
    final response =
        await clientConfig.post(path: '/onboard/complete', body: body);
    return CurrentUser.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<RelationUser> fetchUser(RevHttpClient httpClient,
    {required String id,}) async {
  try {
    final response = await httpClient.get(path: '/users/$id');
    return RelationUser.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<RelationUser> sendFriendRequest(RevHttpClient httpClient,
    {required String username,}) async {
  final body = json.encode({
    'username': username,
  });
  try {
    final response = await httpClient.post(path: '/users/friend', body: body);
    return RelationUser.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<RelationUser> acceptFriendRequest(
  RevHttpClient httpClient, {
  required String id,
}) async {
  try {
    final response = await httpClient.put(
      path: '/users/$id/friend',
    );
    return RelationUser.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<Channel> openDirectMessageChannel(RevHttpClient httpClient,
    {required String id,}) async {
  try {
    final response = await httpClient.get(path: '/users/$id/dm');
    return Channel.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<Channel> fetchChannel(RevHttpClient httpClient,
    {required String channelId,}) async {
  try {
    final response = await httpClient.get(path: '/channels/$channelId');
    return Channel.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<List<Channel>> fetchDirectMessageChannels(
  RevHttpClient httpClient,
) async {
  try {
    final response = await httpClient.get(path: '/users/dms');
    return List<Channel>.from(parseJsonToList(response.body).map((v) {
      return Channel.fromJson(v as Map<String, dynamic>);
    }),);
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

// TODO(mtrxhead): move this to a seperate module of channels.
Future<(List<Message>, List<RelationUser>)> fetchMessages(
    {required RevHttpClient httpClient,
    required String id,
    int? limit,
    String? before,
    String? after,
    String? sort,
    String? nearby,
    bool? includeUsers,}) async {
  final queries = {
    'limit': limit,
    'after': after,
    'sort': sort,
    'nearby': nearby,
    'include_users': includeUsers?.toString(),
  }..removeWhere((key, value) => value == null);
  try {
    final response = await httpClient.get(
        path: '/channels/$id/messages', queryParameters: queries,);

    if (includeUsers != null && includeUsers) {
      // ignore: prefer_collection_literals
      final  messages = <Message>[];
      final json = parseJsonToMap(response.body);
      for (final messageJson
          in json['messages'] as List<Map<String, dynamic>>) {
        final message = Message.fromJson(messageJson);
        messages.add(message);
      }
      final users = List<RelationUser>.from(
          (json['users'] as List<Map<String, dynamic>>).map((v) {
        return RelationUser.fromJson(v);
      }),);
      return (messages, users);
    } else {
      // ignore: prefer_collection_literals
      final  messages = <Message>[];
      for (final messageJson in parseJsonToList(response.body)) {
        final message = Message.fromJson(messageJson as Map<String,dynamic>);
        messages.add(message);
      }

      return (messages, <RelationUser>[]);
    }
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<Message> sendMessage(
    {required RevHttpClient httpClient,
    required String channelId,
    required String content,
    required String idempotencyKey,}) async {
  final body = json.encode({
    'content': content,
  });
  final headers = {
    'Idempotency-Key': idempotencyKey,
  };

  try {
    final response = await httpClient.post(
        path: '/channels/$channelId/messages', headers: headers, body: body,);
    return Message.fromJson(parseJsonToMap(response.body));
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}
