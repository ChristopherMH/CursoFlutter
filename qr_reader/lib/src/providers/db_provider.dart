import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';
export 'package:qrreaderapp/src/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE Scans (id INTEGER PRIMARY KEY, type TEXT, value TEXT)");
    });
  }

  //=========================INSERT=========================

  newScanRaw(ScanModel newScan) async {
    final db = await database;

    final res = await db.rawInsert("INSERT INTO Scans "
        "VALUES (${newScan.id}, '${newScan.type}', '${newScan.value}')");

    return res;
  }

  newScan(ScanModel newScan) async {
    final db = await database;
    final res = db.insert('Scans', newScan.toJson());
    return res;
  }

  //=========================SELECT=========================

  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE TYPE = '$type'");

    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
    return list;
  }

  //==========================UPDATE==========================

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);

    return res;
  }

  //===========================DELETE===========================

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');

    return res;
  }

  Future<int> deleteAllMaps() async {
    final db = await database;
    final res = await db.delete('Scans', where: 'type = ?', whereArgs: ['geo']);

    return res;
  }

  Future<int> deleteAllAddresses() async {
    final db = await database;
    final res =
        await db.delete('Scans', where: 'type = ?', whereArgs: ['http']);

    return res;
  }
}
