import 'package:template/data/models/user/user.model.dart';

class UserUtils {
  static bool isMe({User? currentProfile, User? user}) {
    if (currentProfile == null || user == null) {
      return false;
    }
    return currentProfile.id == user.id;
  }
}
