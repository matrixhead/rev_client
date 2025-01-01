import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/data/channel_repo.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:rxdart/rxdart.dart';

class RevState {
  RevState();
  final ChannelRepositoryState channelRepoState = ChannelRepositoryState();
  final AuthenticationRepositoryState authRepoState =
      AuthenticationRepositoryState();
  final UserRepositoryState userRepoState = UserRepositoryState();
}

class UserRepositoryState {
  final BehaviorSubject<Map<String, RelationUser>> relationUsers =
      BehaviorSubject.seeded(<String, RelationUser>{});
  CurrentUser? currentUser;
}

class ChannelRepositoryState {
  final Map<String, RevChannelState> channelStates = {};
  final Map<String, String> dmchannelUserMappings = {};
}

class AuthenticationRepositoryState {
  BehaviorSubject<AuthStatus> authEvents = BehaviorSubject<AuthStatus>.seeded(
    AuthStatus.unknown,
    sync: true,
  );
  SessionDetails? session;
}

class RevChannelState {
  RevChannelState({required this.channel});

  Channel channel;

  final List<ClientRevMessage> sentMessages = [];

  final List<ServerRevMessage> messages = [];

  final BehaviorSubject<Iterable<RevMessage>> messagesSubject =
      BehaviorSubject.seeded([]);
}
