import 'dart:async';

import 'package:iglo_world/core/models/user.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  Api _api = locator<Api>();
  
  StreamController<User> userController = StreamController<User>();

  Future<bool> login(String username, String password) async {
    User user = await _api.fetchLogin(username, password);
    var hasUser =user.userName != null;
    if (hasUser) {
      userController.add(user);
      print(user.listMenu);
      setSharedPreferences(user.userName, user.token, user.listMenu, user.roleId, user.userType);
    }

    return hasUser;
  }

  setSharedPreferences(String strUserId, String strToken, List listMenu, String strRoleId, String strUserType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('username', strUserId);
    prefs.setString('token', strToken);
    prefs.setStringList("list_menu", listMenu);
    prefs.setBool('is_login', true);
    prefs.setString('role_id', strRoleId);
    prefs.setString('user_type', strUserType);
  }

}