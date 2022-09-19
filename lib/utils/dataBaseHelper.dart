import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DataBaseHelper {
  DataBaseHelper.constructor();
  static final instance = DataBaseHelper.constructor();
  static const dbName = 'notes.db';
  static const dbVersion = 1;
  static final tableName = ["NOTES"];

  static String noteStringText = "noteString";
  static String pinnedBool = "pinned";
  static String deletedBool = "deleted";
  static String lastModifyDInt = "lastModifyD";
  static String lastModifyMInt = "lastModifyM";
  static String lastModifyYInt = "lastModifyY";

  static Database? db;
  Future<Database> get get_database async => db ??= await initiateDB();

  Future<Database> initiateDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreateFun);
  }

  Future onCreateFun(Database db, int version) async {
    await db.execute('''
CREATE TABLE ${tableName[0]}(
  id INTEGER PRIMARY KEY,
  $noteStringText TEXT,
  $pinnedBool INTEGER,
  $deletedBool INTEGER,
  $lastModifyDInt INTEGER,
  $lastModifyMInt INTEGER,
  $lastModifyYInt INTEGER);
  ''');
  }

  Future<int> insert(Map<String, dynamic> row, int table) async {
    Database db = await instance.get_database;
    return await db.insert(tableName[table], row);
  }

  Future<List<Map<String, dynamic>>> querryAll(
      List<String> columns, int table) async {
    Database db = await instance.get_database;

    // if (columns.isEmpty) {
    //   return await db.query(tableName[table]);
    // } else {}
    return await db.query(tableName[table],
        columns: columns); //, where: "$deletedBool = ?", whereArgs: [0]
  }

  Future<List<Map<String, dynamic>>> querryID(int id, int table) async {
    Database db = await instance.get_database;
    return await db.query(tableName[table], where: " id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> querryCondition(
      deleted, pinned, int table) async {
    Database db = await instance.get_database;
    return await db.query(tableName[table],
        where: " $deletedBool = ? , $pinnedBool = ? ",
        whereArgs: [deleted, pinned]);
  }

  Future<int> update(Map<String, dynamic> row, int table) async {
    Database db = await instance.get_database;
    int id = row["id"];
    return db.update(tableName[table], row, where: " id = ?", whereArgs: [id]);
  }

  Future<int> delete(int id, int table) async {
    Database db = await instance.get_database;
    return await db.delete(tableName[table], where: " id = ?", whereArgs: [id]);
  }
}
