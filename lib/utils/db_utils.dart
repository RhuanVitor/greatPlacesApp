import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtils {
  static Future<sql.Database> Database() async{
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version){
        return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)'
        ).then((error) { debugPrint("resultado");});
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async{
    final db = await DbUtils.Database();
    await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getData(String table) async{
    final db = await DbUtils.Database();
    return db.query(table);
  }
}