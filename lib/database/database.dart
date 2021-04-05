import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/issues_dao.dart';
import 'record/issue_record.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [IssueRecord])
abstract class FlutterDatabase extends FloorDatabase {
  IssuesDao get issuesDao;
}