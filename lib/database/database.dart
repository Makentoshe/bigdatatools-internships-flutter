import 'dart:async';
import 'package:bigdatatools_internships/database/record/tag_record.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/issues_dao.dart';
import 'dao/tags_dao.dart';
import 'record/issue_record.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [IssueRecord, TagRecord])
abstract class FlutterDatabase extends FloorDatabase {

  IssuesDao get issuesDao;

  TagsDao get tagsDao;
}