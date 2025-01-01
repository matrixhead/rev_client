import 'dart:async';

import 'package:collection/collection.dart';
import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/data/channel_repo.dart';
import 'package:revolt_client/src/data/user_repo.dart';
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/ws_events/ws_events.dart';
import 'package:revolt_client/src/state/rev_state.dart';
import 'package:rxdart/transformers.dart';

class RevData {
  RevData(this.state, this.httpClient)
    : channelRepo = ChannelReposotory(state: state),
      userRepo = UserRepository(state: state);
  final RevState state;
  final RevHttpClient httpClient;
  final ChannelReposotory channelRepo;
  final UserRepository userRepo;

  Future<CurrentUser> fetchSelf() async {
    if (state.userRepoState.currentUser case final CurrentUser cu) {
      return cu;
    }
    try {
      return api.fetchSelf(httpClient);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> fetchUser({required String id}) {
    try {
      return api.fetchUser(httpClient, id: id);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> sendFriendRequest({required String username}) {
    try {
      return api.sendFriendRequest(httpClient, username: username);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RelationUser> acceptFriendRequest({required String id}) async {
    try {
      final user = await api.acceptFriendRequest(httpClient, id: id);
      userRepo.addorUpdateRelationUsers(user);
      return user;
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RevChannel> getDmChannelForUser({required String userid}) async {
    if (channelRepo.getDmChannelForUser(userid) case final RevChannel channel) {
      return channel;
    }
    return openDirectMessageChannel(id: userid);
  }

  Future<RevChannel> openDirectMessageChannel({required String id}) async {
    try {
      final channel = await api.openDirectMessageChannel(httpClient, id: id);
      channelRepo.addChannelUserMapping((await fetchSelf()).id, channel);
      return channelRepo.addOrUpdateChannel(channel);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<RevChannel> fetchChannel({required String channelId}) async {
    if (channelRepo.getChannelforId(channelId) case final RevChannel channel) {
      return channel;
    }
    try {
      final channel = await api.fetchChannel(httpClient, channelId: channelId);
      if (channel.channelType == ChannelType.directMessage) {
        channelRepo.addChannelUserMapping((await fetchSelf()).id, channel);
      }
      return channelRepo.addOrUpdateChannel(channel);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<List<Channel>> fetchDirectMessageChannels(RevHttpClient httpClient) {
    try {
      return api.fetchDirectMessageChannels(httpClient);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<void> fetchMessages({
    required String id,
    int? limit,
    String? before,
    String? after,
    String? sort,
    String? nearby,
    bool? includeUsers,
  }) async {
    try {
      final (messages, _) = await api.fetchMessages(
        httpClient: httpClient,
        id: id,
        after: after,
        before: before,
        includeUsers: includeUsers,
        limit: limit,
        nearby: nearby,
        sort: sort,
      );
      channelRepo.getChannelforId(id)?.addMessages(messages);
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<Message> sendMessage({
    required String channelId,
    required String content,
    required String idempotencyKey,
  }) async {
    try {
      channelRepo
          .getChannelforId(channelId)!
          .addSendMessage(
            ClientRevMessage(
              content: content,
              idempotencyKey: idempotencyKey,
              author: (await fetchSelf()).id,
            ),
          );
      final message = await api.sendMessage(
        httpClient: httpClient,
        channelId: channelId,
        content: content,
        idempotencyKey: idempotencyKey,
      );
      // We are ignoring the returned value of the message call here, as the
      // WebSocket will handle adding it to the state.
      return message;
    } on RevApiError catch (e) {
      throw DataError.fromApiError(e);
    }
  }

  Future<void> onReadyEvent(ReadyEvent readyEvent) async {
    final currentRU = state.userRepoState.relationUsers.value;
    for (final user in readyEvent.users) {
      switch (user) {
        case final RelationUser relationUser:
          currentRU[relationUser.id] = relationUser;
        case final CurrentUser currentUser:
          state.userRepoState.currentUser = currentUser;
      }
    }
    state.userRepoState.relationUsers.add(currentRU);
    for (final channel in readyEvent.channels) {
      channelRepo.addOrUpdateChannel(channel);
      if (channel.channelType == ChannelType.directMessage) {
        channelRepo.addChannelUserMapping(
          state.userRepoState.currentUser!.id,
          channel,
        );
      }
    }
  }

  Future<void> onMessageEvent(MessageEvent messageEvent) async {
    final channel = await fetchChannel(channelId: messageEvent.message.channel);
    channel.addMessages([messageEvent.message]);
  }

  void onUserRelationShipEvent(UserRelationShipEvent userRelationShipEvent) {
    userRepo.addorUpdateRelationUsers(userRelationShipEvent.user);
  }

  void onChannelCreateEvent(ChannelCreateEvent channelCreateEvent) {
    channelRepo.addOrUpdateChannel(channelCreateEvent.channel);
    if (channelCreateEvent.channel.channelType == ChannelType.directMessage) {
      channelRepo.addChannelUserMapping(
        state.userRepoState.currentUser!.id,
        channelCreateEvent.channel,
      );
    }
  }

  Future<List<RelationUser>> fetchOtherUsersForChannel(
    RevChannel channel,
  ) async {
    final cu = await fetchSelf();
    if (channel.channelType == ChannelType.directMessage) {
      final otherUserId = channel.recipients.firstWhere((id) => id != cu.id);
      final user = await fetchUser(id: otherUserId);
      userRepo.addorUpdateRelationUsers(user);
      return [user];
    }
    throw UnimplementedError('implement for group');
  }

  Stream<Map<String, RelationUser>> getOtherUsersForChannelStream(
    RevChannel channel,
  ) async* {
    final cu = await fetchSelf();
    final shouldFetchUsers =
        !channel.recipients.every((userId) {
          return userRepo.relationUsers.containsKey(userId) || userId == cu.id;
        });
    if (shouldFetchUsers) {
      await fetchOtherUsersForChannel(channel);
    }

    yield* userRepo.relationUsersStream
        .map((relationUsers) {
          return Map.fromEntries(
            channel.recipients
                .where((userId) => userId != cu.id)
                .map((userID) => MapEntry(userID, relationUsers[userID]!)),
          );
        })
        .scan(
          (old, otherUsers, _) => [old[1], otherUsers],
          <Map<String, RelationUser>>[{}, {}],
        )
        .where((oldAndNewOu) {
          final shouldEmit =
              !const MapEquality<String, RelationUser>().equals(
                oldAndNewOu[0],
                oldAndNewOu[1],
              );
          return shouldEmit;
        })
        .map((oldAndNewOu) {
          return oldAndNewOu[1];
        });
  }
}
