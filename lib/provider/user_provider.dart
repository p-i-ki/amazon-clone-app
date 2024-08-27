import 'package:amazone_clone_by_rivaan/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '');

  User get user => _user;

  void setUser(String user) {
    //It decodes the JSON string(response comming from server) to a map using json.decode and then uses fromMap to create the User instance.
    //json -> map using json.decode() then map -> User instance using fromMap()
    _user = User.fromJson(user);
    notifyListeners(); //to trigger rebuild of all the changenotifier's subscribers.
  }
}
