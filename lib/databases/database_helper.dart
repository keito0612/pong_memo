import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._();
  static final DataBaseHelper db = DataBaseHelper._();
  static const _databaseName = "pong_memo.db";
  static const _databaseVersion = 1;
  static const tableGame = 'game';
  static const tableScores = 'scores';
  static const columnId = 'id';
  static const columnscore = 'score';
  static const columnPartnerScore = 'partnerScore';
  static const columnDate = 'date';
  static const columnScoresId = 'scores_id';
  static const columnTitle = "title";
  static const columnOpponentSetCount = "opponentSetCount";
  static const columnOwnSetCount = "ownSetCount";
  static const columnVictoryStatus = "victoryStatus";
  static const columngoodMemo = 'goodMemo';
  static const columnbadMemo = 'badMemo';
  static const columnRacketStatus = 'racketStatus';
  static const columnDominantHandStatus = 'dominantHandStatus';
  static const columnForeRubberStatus = 'foreRubberStatus';
  static const columnBackRubberStatus = 'backRubberStatus';
  static const columnBattleTypeStatus = 'battleTypeStatus';
  static Database? _database;

  static Future rawDelete({String? tableName}) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    final datebase = await openDatabase(path);
    await datebase.rawDelete('DELETE FROM $tableName');
  }

  Future<Database> initDB() async {
    //データベースを作成
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    final Future<Database> _database = openDatabase(
      path,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON;');
      },
      onCreate: (db, version) async {
        await db.execute(
            // テーブルの作成
            "CREATE TABLE $tableGame ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,  $columnTitle TEXT,  $columnDominantHandStatus INTEGER,  $columnBattleTypeStatus INTEGER, $columnBackRubberStatus INTEGER $columnForeRubberStatus INTEGER, $columnRacketStatus INTEGER  $columnDate TEXT,$columngoodMemo TEXT, $columnbadMemo TEXT)");
        await db.execute(
            "CREATE TABLE $tableScores ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,  $columnscore INTEGER, $columnPartnerScore INTEGER )");
      },
      version: _databaseVersion,
    );
    return _database;
  }
}
