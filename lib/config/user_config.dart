import 'package:learn/models/user_model.dart';

class UserConfig {
  UserConfig._();

  static final UserConfig _userConfig = UserConfig._();

  factory UserConfig() {
    return _userConfig;
  }

  static UserModel? _userModel;

  static UserModel? get userModel => _userModel;

  static void setUserModel(UserModel userModel) {
    _userModel = userModel;
  }
}
