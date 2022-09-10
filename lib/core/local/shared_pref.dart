import 'package:shared_preferences/shared_preferences.dart';

import '../utils/nike_notifiers.dart';

abstract class NikeSharedPref {
  Future<UserDataModel> getUser();
  Future<void> saveUser({required UserDataModel dataModel});
  Future<void> removeUser();
}

class NikeSharedPrefImpl implements NikeSharedPref {
  @override
  Future<UserDataModel> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getString("userId") ?? "";
    final email = preferences.getString("email") ?? "";
    final password = preferences.getString("pass") ?? "";
    if (email.isNotEmpty && !NikeNotifiers.authRefreshNotifier.value) {
      NikeNotifiers.authRefreshNotifier.value = true;
    }
    return UserDataModel(userId: userId, email: email, password: password);
  }

  @override
  Future<void> saveUser({required UserDataModel dataModel}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", dataModel.userId ?? "");
    await prefs.setString("email", dataModel.email ?? "");
    await prefs.setString("pass", dataModel.password ?? "");
    NikeNotifiers.authRefreshNotifier.value = true;
  }

  @override
  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    NikeNotifiers.authRefreshNotifier.value = false;
  }
}

class UserDataModel {
  final String? userId;
  final String? email;
  final String? password;

  UserDataModel(
      {required this.userId, required this.email, required this.password});
}
