import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shalomhouse/constants/shared_pref_keys.dart';
import 'package:shalomhouse/data/user_model.dart';
import 'package:shalomhouse/repo/user_service.dart';
import 'package:shalomhouse/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier() {
    initUser();
  }

  User? _user;
  UserModel? _userModel;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      await _setNewUser(user);
      notifyListeners();
    });
  }

  Future _setNewUser(User? user) async {
    _user = user;
    if (user != null && user.phoneNumber != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      String phoneNumber = user.phoneNumber!;
      String userKey = user.uid;
      UserModel userModel = UserModel(
          userKey: "",
          phoneNumber: phoneNumber,
  //        address: address,
          createdDate: DateTime.now().toUtc());
      await UserService().createNewUser(userModel.toJson(), userKey);
      _userModel = await UserService().getUserModel(userKey);
      logger.d(_userModel!.toJson().toString());
    }
  }

  User? get user => _user;
}
