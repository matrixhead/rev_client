import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:revolt_client/revolt_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'revolt_client_test.dart';

typedef Client = http.Client;

void registerLoginStub(Client client, RevConfig config) {
  when(
    client.post(
      Uri.parse(
        'http://${config.baseUrl}:${config.httpPort}/auth/session/login',
      ),
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    ),
  ).thenAnswer(
    (_) async => http.Response(
      '{'
      '"result":"Success",'
      '"_id":"01FNEVYZQGP2KT62SKVVF7WHW8",'
      '"user_id":"01FN6NZ4PJRE55128RHC7FTVSC",'
      '"token":"YOgo7yqjO8zGKs5l-iZimvrLib",'
      '"name":"Unknown"'
      '}',
      200,
    ),
  );
}

void registerOnboardingStub(
  Client client,
  RevConfig config, {
  required bool onboardingStatus,
}) {
  when(
    client.get(
      Uri.parse('http://${config.baseUrl}:${config.httpPort}/onboard/hello'),
      headers: anyNamed('headers'),
    ),
  ).thenAnswer(
    (_) async =>
        http.Response(jsonEncode({'onboarding': onboardingStatus}), 200),
  );
}

void registerSignupStub(Client client, RevConfig config) {
  when(
    client.post(
      Uri.parse(
        'http://${config.baseUrl}:${config.httpPort}/auth/account/create',
      ),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),
  ).thenAnswer((_) async => http.Response('', 204));
}

void registerverifyStub(
  Client client,
  RevConfig config,
  String verificationCode,
) {
  when(
    client.post(
      Uri.parse(
        'http://${config.baseUrl}:${config.httpPort}/auth/account/verify/$verificationCode',
      ),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),
  ).thenAnswer((_) async => http.Response('', 200));
}

void registerCompleteOnboardingStub(
  Client client,
  RevConfig config,
  String username,
) {
  final responseBody = {
    '_id': '01JFA9RPGMRVXDNDMMXGZGTVQ7',
    'username': 'myuser',
    'discriminator': '3549',
    'relationship': 'User',
    'online': false,
  };
  when(
    client.post(
      Uri.parse('http://${config.baseUrl}:${config.httpPort}/onboard/complete'),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),
  ).thenAnswer((_) async => http.Response(jsonEncode(responseBody), 200));
}

void registeracceptFriendRequestStub(
  Client client,
  RevConfig config,
  String id,
) {
  when(
    client.put(
      Uri.parse('http://${config.baseUrl}:${config.httpPort}/users/$id/friend'),

      headers: anyNamed('headers'),
      body: anyNamed('body'),
      encoding: anyNamed('encoding'),
    ),
  ).thenAnswer(
    (_) async => http.Response(
      jsonEncode(mockJson['accept_friend_request_response']),
      200,
    ),
  );
}

void registerOpenDmStub(Client client, RevConfig config, String id) {
  when(
    client.get(
      Uri.parse('http://${config.baseUrl}:${config.httpPort}/users/$id/dm'),
      headers: anyNamed('headers'),
    ),
  ).thenAnswer(
    (_) async => http.Response(jsonEncode(mockJson['open_dm_response']), 200),
  );
}

void registerSendMessageStub(
  Client client,
  RevConfig config,
  String channelId,
) {
  when(
    client.post(
      Uri.parse(
        'http://${config.baseUrl}:${config.httpPort}/channels/$channelId/messages',
      ),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
      encoding: anyNamed('encoding'),
    ),
  ).thenAnswer(
    (_) async =>
        http.Response(jsonEncode(mockJson['send_message_response']), 200),
  );
}

void addMockReadyevent(WebSocketChannel ws) {
  if (ws case final MockWebSocketChannel mws) {
    mws.mockStreamController.add(jsonEncode(mockJson['ready_event']));
  }
}

void addMockUserRelationshipWithIncoming(WebSocketChannel ws) {
  if (ws case final MockWebSocketChannel mws) {
    mws.mockStreamController.add(
      jsonEncode(mockJson['user_relationship_incoming']),
    );
  }
}

void addChannelcreateEventForDm(WebSocketChannel ws) {
  if (ws case final MockWebSocketChannel mws) {
    mws.mockStreamController.add(jsonEncode(mockJson['channel_create_dm']));
  }
}

void addMessageEventForDm(WebSocketChannel ws) {
  if (ws case final MockWebSocketChannel mws) {
    mws.mockStreamController.add(jsonEncode(mockJson['message_event']));
  }
}

void addMessageEventAfterSentMessage(WebSocketChannel ws) {
  if (ws case final MockWebSocketChannel mws) {
    mws.mockStreamController.add(
      jsonEncode(mockJson['message_event_after_send_message']),
    );
  }
}
