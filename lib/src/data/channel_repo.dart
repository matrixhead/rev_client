import 'dart:collection';

import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/state/rev_state.dart';
import 'package:rxdart/rxdart.dart';

class ChannelReposotory {
  ChannelReposotory({required this.state});

  final RevState state;

  RevChannel addOrUpdateChannel(Channel channel) {
    if (state.channelRepoState.channelStates[channel.id]
        case final RevChannelState channelState) {
      final revChannel = RevChannel(channelState: channelState)
        .._updateChannel(channel);
      return revChannel;
    }
    final channelState = RevChannelState(channel: channel);
    state.channelRepoState.channelStates[channel.id] = channelState;

    return RevChannel(channelState: channelState);
  }

  void addChannelUserMapping(String currentuserId, Channel dmChannel) {
    final otherUserId = dmChannel.recipients.firstWhere(
      (val) => val != currentuserId,
    );
    state.channelRepoState.dmchannelUserMappings[otherUserId] = dmChannel.id;
  }

  RevChannel? getDmChannelForUser(String userid) {
    final channelId = state.channelRepoState.dmchannelUserMappings[userid];
    if (state.channelRepoState.channelStates[channelId]
        case final RevChannelState channelState) {
      return RevChannel(channelState: channelState);
    }
    return null;
  }

  RevChannel? getChannelforId(String channelId) {
    if (state.channelRepoState.channelStates[channelId]
        case final RevChannelState channelState) {
      return RevChannel(channelState: channelState);
    }
    return null;
  }
}

/// A class representing a channel in the Revolt client.
class RevChannel {
  RevChannel({required RevChannelState channelState})
    : _channelState = channelState;

  final RevChannelState _channelState;

  Channel get _channel => _channelState.channel;

  List<ClientRevMessage> get _sentMessages => _channelState.sentMessages;

  List<ServerRevMessage> get _messages => _channelState.messages;

  BehaviorSubject<Iterable<RevMessage>> get messages =>
      _channelState.messagesSubject;

  void emitMessages() {
    final messageIter = _messages.cast<RevMessage>();
    final sentMessagesIter = _sentMessages.cast<RevMessage>();
    final iterable = sentMessagesIter.followedBy(messageIter);
    messages.add(iterable);
  }

  void addSendMessage(ClientRevMessage message) {
    _sentMessages.insert(0, message);
    emitMessages();
  }

  void addMessages(List<Message> messages) {
    for (final (index, message) in messages.indexed) {
      // This operation is somewhat expensive; consider finding a more efficient
      // approach.
      _messages.insert(index, ServerRevMessage.fromMessage(message: message));
      _sentMessages.removeWhere((val) => val.idempotencyKey == message.nonce);
    }
    emitMessages();
  }

  void _updateChannel(Channel channel) {
    _channelState.channel = channel;
  }

  /// Returns the unique identifier of the channel.
  String get id => _channel.id;

  /// Returns a list of recipient IDs associated with the channel.
  List<String> get recipients => _channel.recipients;

  /// Returns the type of the channel.
  ChannelType get channelType => _channel.channelType;
}

abstract class RevMessage {
  RevMessage(this.author, this.idempotencyKey, this.content);

  final String content;
  final String author;
  final String idempotencyKey;
}

class ClientRevMessage implements RevMessage {
  ClientRevMessage({
    required this.content,
    required this.idempotencyKey,
    required this.author,
  });

  @override
  final String content;
  @override
  final String idempotencyKey;
  @override
  final String author;
}

class ServerRevMessage implements RevMessage {
  ServerRevMessage.fromMessage({required this.message});
  final Message message;
  @override
  String get content => message.content;
  @override
  String get idempotencyKey => message.nonce;
  @override
  String get author => message.author;
}
