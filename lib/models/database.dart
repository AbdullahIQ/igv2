import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// class SqlDb {
//   Database? _db;
//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialDb();
//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   intialDb() async {
//     String getPath = await getDatabasesPath();
//     String path = join(getPath, 'favorite.db');

//     Database mydb = await openDatabase(path, onCreate: onCreate, version: 1);
//     return mydb;
//   }

//   onCreate(Database db, int version) async {
//     await db.execute('''
//   CREATE TABLE Favorites (username TEXT)
// ''');
//     // ignore: avoid_print
//     print("============= create database =============");
//   }

//   onUpgrate(Database db, int oldVersion, int newVersion) {}
//   readData(String sql) async {
//     Database? mydb = await db;
//     List<Map> response = await mydb!.rawQuery(sql);
//     return response;
//   }

//   insertData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawInsert(sql);
//     return response;
//   }

//   updateData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawUpdate(sql);
//     return response;
//   }

//   deleteData(String sql) async {
//     Database? mydb = await db;
//     int response = await mydb!.rawDelete(sql);
//     return response;
//   }
// }
class ProfileDb {
  final String name;
  final String profilePicture;
  final bool favorite;
  ProfileDb(
      {required this.name,
      required this.favorite,
      required this.profilePicture});

  factory ProfileDb.fromMap(Map<String, dynamic> json) {
    return ProfileDb(
        name: json['name'],
        favorite: json['favorite'] == 1 ? true : false,
        profilePicture: json["profilePicture"]);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'favorite': favorite == true ? 1 : 0,
      'profilePicture': profilePicture,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    String getPath = await getDatabasesPath();
    String path = join(getPath, 'profileinfo.db');

    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ProfileInfo (
        name TEXT,
        profilePicture TEXT,
        favorite INTEGER NOT NULL
        )
    ''');
    // ignore: avoid_print
    print("============= create database =============");
  }

  Future<List<ProfileDb>> getProfileInfo() async {
    Database? db = await instance.database;
    var info = await db!.rawQuery("SELECT * FROM ProfileInfo");

    List<ProfileDb> profileList =
        info.isNotEmpty ? info.map((e) => ProfileDb.fromMap(e)).toList() : [];
    return profileList;
  }

  Future<int> add(ProfileDb info) async {
    Database? db = await instance.database;

    return await db!.insert("ProfileInfo", info.toMap());
  }

  Future<int> updateDatabase(ProfileDb info) async {
    Database? db = await instance.database;
    return await db!.update("ProfileInfo", info.toMap(),
        where: 'name = ?', whereArgs: [info.name]);
  }

  Future<void> deleteDatabase() async {
    String getPath = await getDatabasesPath();
    String path = join(getPath, 'profileinfo.db');
    String path1 = join(getPath, 'favorite.db');
    databaseFactory.deleteDatabase(path);
    databaseFactory.deleteDatabase(path1);
  }

  deleteData(String sql) async {
    Database? mydb = await instance.database;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
