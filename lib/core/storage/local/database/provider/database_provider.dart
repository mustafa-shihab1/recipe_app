import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../constants/sqflite_constants.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  Database? _database;

  DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  Database? get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, SqfLiteConstants.dbPath);
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('DB created');
        return await db
            .execute(
              'CREATE TABLE ${SqfLiteConstants.tableName} ( ${SqfLiteConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, ${SqfLiteConstants.columnName} TEXT, ${SqfLiteConstants.columnCategory} TEXT, ${SqfLiteConstants.columnArea} TEXT, ${SqfLiteConstants.columnInstructions} TEXT, ${SqfLiteConstants.columnImage} TEXT, ${SqfLiteConstants.columnIsFavorite} INTEGER DEFAULT 0 )',
            )
            .then((value) => print('Table created'));
      },
      onOpen: (db) {
        print('DB opened');
      },
      onUpgrade: (db, oldVersion, newVersion) async {},
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}
