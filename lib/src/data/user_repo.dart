import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/state/rev_state.dart';

class UserRepository {
  UserRepository({required this.state});

  final RevState state;

  UserRepositoryState get _userRepo => state.userRepoState;

  Map<String, RelationUser> get relationUsers => _userRepo.relationUsers.value;

  Stream<Map<String, RelationUser>> get relationUsersStream =>
      _userRepo.relationUsers.stream;
  void addorUpdateRelationUsers(RelationUser user) {
    final users = Map<String, RelationUser>.from(_userRepo.relationUsers.value);
    users[user.id] = user;
    _userRepo.relationUsers.add(users);
  }
}
