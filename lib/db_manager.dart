import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class DbManager {
  Database _database;
  String _tableName = '';

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), 'formdata.db'),
          version: 1, onCreate: (Database db, int version) async {
            //Create table
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARYKEY, name TEXT, course TEXT)');
      });
    }
  }

  //Insert Data
  Future<int> insertFormData(AppFormData data ) async {
    await openDb();
    return await _database.insert('formdata', data.toMap());
  }

  //Get Data
  Future<List<AppFormData>> getFormData() async {
    await openDb();
    List<Map<String, dynamic>> maps = await _database.query('formdata');
    return List.generate(maps.length, (i) {
      return AppFormData(
          id: maps[i]['id'], name: maps[i]['name'], course: maps[i]['course']);
    });
  }

  Future<int> updateFormData(AppFormData data) async {
    await openDb();
    return await _database.update('formdata', data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
  }

  Future<int> deleteFormData(int id) async {
    await openDb();
    return await _database.delete('formdata', where: "id = ?", whereArgs: [id]);
  }
}

class AppFormData {
  int id;
  String name;
  String course;

  AppFormData({@required this.name, @required this.course, this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'course': course};
  }
}
