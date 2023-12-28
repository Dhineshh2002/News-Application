import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDetail {
  String userName;
  String userEmail;
  String password;

  UserDetail({
    required this.userName,
    required this.userEmail,
    required this.password,
  });

  factory UserDetail.fromMap(Map<String, Object?> map) {
    return UserDetail(
      userName: map['user_name'] as String,
      userEmail: map['user_email'] as String,
      password: map['password'] as String,
    );
  }

  Map<String, String> toMap() {
    return {
      'user_name': userName,
      'user_email': userEmail,
      'password': password,
    };
  }
}

class UserDetailsDatabase {
  Future<Database> getDatabase() async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'UserDetailDB.db'),
      version: 1,
      onCreate: (Database db, int version) {
        return db.execute(
          'CREATE TABLE UserDetail (user_name TEXT, user_email TEXT, password TEXT)',
        );
      },
    );
    return db;
  }

  Future<bool> insertRecord(UserDetail user) async {
    Database db = await getDatabase();

    List<Map<String, Object?>> map = await db.query('UserDetail');

    for (int i = 0; i < map.length; i++) {
      if (map[i]['user_email'] == user.userEmail) {
        return false;
      }
    }

    await db.insert(
      'UserDetail',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return true;
  }

  Future<List<UserDetail>> retrieveRecords() async {
    Database db = await getDatabase();
    List<Map<String, Object?>> map = await db.query('UserDetail');

    List<UserDetail> users = List.generate(
      map.length,
          (index) {
        return UserDetail.fromMap(map[index]);
      },
    );

    return users;
  }
}