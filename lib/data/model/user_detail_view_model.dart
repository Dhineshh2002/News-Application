import 'package:flutter/cupertino.dart';

import '../providers/user_detail.dart';

class UserDetailViewModel extends ChangeNotifier {
  UserDetailsDatabase db = UserDetailsDatabase();
  List<UserDetail> users = [];
  bool flag = false;

  Future<void> gettingUsers() async {
    users = await db.retrieveRecords();
  }

  void insertingUserDetail (UserDetail user) async {
    flag = await db.insertRecord(user);
  }
}