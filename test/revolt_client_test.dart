import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/data/channel_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'dummy.dart';
@GenerateNiceMocks([
  MockSpec<http.Client>(),
  MockSpec<SharedPreferencesAsync>(),
  MockSpec<WebSocketChannel>(as: #$MockWebSocketChannel),
  MockSpec<WebSocketSink>(),
])
import 'revolt_client_test.mocks.dart';
import 'stubs.dart';

const mock = !(String.fromEnvironment('NO-MOCK') == 'true');

late final Map<String, dynamic> mockJson;

class MockWebSocketChannel extends $MockWebSocketChannel {
  final StreamController<dynamic> mockStreamController =
      StreamController.broadcast(sync: true);
  final MockWebSocketSink _sink = MockWebSocketSink();

  @override
  WebSocketSink get sink => _sink;

  @override
  Stream<dynamic> get stream {
    return mockStreamController.stream;
  }
}

void main() async {
  late RevConfig config;
  late http.Client mockhttpClient;
  late WebSocketChannel ws;
  late RevoltClient revoltClient;
  late SharedPreferencesAsync prefs;

  const filePath = 'test/test_resources/mock_data.json';
  final file = File(filePath);
  final jsonString = await file.readAsString();
  mockJson = jsonDecode(jsonString) as Map<String, dynamic>;

  setUp(() async {
    config = RevConfig.debug();
    prefs = MockSharedPreferencesAsync();
    mockhttpClient = MockClient();
    ws = MockWebSocketChannel();
    if (mock) {
      revoltClient = RevoltClient(
        httpClient: mockhttpClient,
        clientConfig: config,
        sharedPreferences: prefs,
        wsChannel: ws,
      );
    } else {
      revoltClient = RevoltClient(
        clientConfig: config,
        sharedPreferences: prefs,
      );
    }
  });
  group('auth', () {
    test('signup', () async {
      registerSignupStub(mockhttpClient, config);
      await revoltClient.signUp(email: dummyEmail, password: dummyPassword);
    });

    test('verify account', () async {
      const verficationCode = 'HhIB4s1ObXyo4hPw3d2M8tHzAiDFBwn2';
      registerverifyStub(mockhttpClient, config, verficationCode);
      await revoltClient.verifyAccount(verificationCode: verficationCode);
    });

    test('emits auth success if the login completes succesfully', () async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: false);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      if (mock) {
        verify(ws.sink.add(argThat(contains('"type":"Authenticate"'))));
        addMockReadyevent(ws);
      }
      await expectLater(
        revoltClient.authEvents,
        emitsThrough(AuthStatus.authsucess),
      );
    });

    test('emits notOnboarded', () async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: true);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      await expectLater(
        revoltClient.authEvents,
        emits(AuthStatus.notOnboarded),
      );
    });
    test('emits authsuccess after onboarding', () async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: true);
      registerCompleteOnboardingStub(mockhttpClient, config, dummyUsername);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      await expectLater(
        revoltClient.authEvents,
        emits(AuthStatus.notOnboarded),
      );
      await revoltClient.completeOnboarding(username: dummyUsername);
      if (mock) {
        verify(ws.sink.add(argThat(contains('"type":"Authenticate"'))));
        addMockReadyevent(ws);
      }
      await expectLater(
        revoltClient.authEvents,
        emitsThrough(AuthStatus.authsucess),
      );
    });
  });
  group('user', () {
    setUp(() async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: false);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      if (mock) {
        addMockReadyevent(ws);
      }
    });

    test('relationUsersStream emits after readyevent', () async {
      if (mock) {
        await expectLater(
          revoltClient.relationUsersStream,
          emitsThrough(
            predicate<Map<String, RelationUser>>((map) {
              const id = '2';
              return map.containsKey(id);
            }),
          ),
        );
      }
    });
    test('relationUsersStream emits after accept friend request', () async {
      if (mock) {
        addMockUserRelationshipWithIncoming(ws);
        registeracceptFriendRequestStub(mockhttpClient, config, '3');
        await revoltClient.acceptFriendRequest(id: '3');
        await expectLater(
          revoltClient.relationUsersStream,
          emits(
            predicate<Map<String, RelationUser>>((map) {
              return map['3']!.relationStatus == RelationStatus.friend;
            }),
          ),
        );
      }
    });
  });

  group('channel', () {
    setUp(() async {
      registerLoginStub(mockhttpClient, config);
      registerOnboardingStub(mockhttpClient, config, onboardingStatus: false);
      await revoltClient.login(email: dummyEmail, password: dummyPassword);
      addMockReadyevent(ws);
    });
    test('fetch channel for user', () async {
      final channel = await revoltClient.getDmChannelForUser(userId: '2');
      expect(channel.id, 'channel_id_1');
    });
    test('open a new dm channel after accepting friend request', () async {
      addMockUserRelationshipWithIncoming(ws);
      registeracceptFriendRequestStub(mockhttpClient, config, '3');
      await revoltClient.acceptFriendRequest(id: '3');
      // channel didn't exist so client need to sent a open dm request to
      // server.
      registerOpenDmStub(mockhttpClient, config, '3');
      final channel = await revoltClient.getDmChannelForUser(userId: '3');
      expect(channel.id, 'channel_id_2');
    });

    test('channelcreate event loads channel', () async {
      addMockUserRelationshipWithIncoming(ws);
      registeracceptFriendRequestStub(mockhttpClient, config, '3');
      await revoltClient.acceptFriendRequest(id: '3');
      // channel didn't exist so client need to sent a open dm request to
      // server.
      addChannelcreateEventForDm(ws);
      final channel = await revoltClient.getDmChannelForUser(userId: '3');
      expect(channel.id, 'channel_id_2');
    });

    test('recieve message dm', () async {
      final channel = await revoltClient.getDmChannelForUser(userId: '2');
      final messageStreamMatchFuture = expectLater(
        channel.messages,
        emitsInOrder([
          <RevMessage>[],
          predicate<Iterable<RevMessage>>((messages) {
            return messages.any(
              (message) => message.content == 'hi this is a unique message',
            );
          }),
        ]),
      );
      addMessageEventForDm(ws);
      await messageStreamMatchFuture;
    });

    test('sent message dm', () async {
      final channel = await revoltClient.getDmChannelForUser(userId: '2');
      final messageStreamMatchFuture = expectLater(
        channel.messages,
        emitsInOrder([
          <RevMessage>[],
          predicate<Iterable<RevMessage>>((messages) {
            return messages.any(
              (message) =>
                  message.content == 'hi this is a unique message' &&
                  message is ClientRevMessage,
            );
          }),
          predicate<Iterable<RevMessage>>((messages) {
            return messages.any(
              (message) =>
                  message.content == 'hi this is a unique message' &&
                  message is ServerRevMessage,
            );
          }),
        ]),
      );
      registerSendMessageStub(mockhttpClient, config, channel.id);
      await revoltClient.sendMessage(
        channelId: channel.id,
        content: 'hi this is a unique message',
      );
      addMessageEventAfterSentMessage(ws);
      await messageStreamMatchFuture;
    });
  });
}
