import 'dart:math';

import 'package:bigdatatools_internships/database/dao/issues_dao.dart';
import 'package:bigdatatools_internships/database/database.dart';
import 'package:bigdatatools_internships/database/record/issue_record.dart';
import 'package:bigdatatools_internships/screen/issues/model/issue.dart';
import 'package:flutter/cupertino.dart';

class IssuesViewModel extends ChangeNotifier {
  IssuesViewModel() {
    // database.then((database) {
    //   database.issuesDao.getAll().then((issues) {
        // this.issues.addAll(issues.map((record) => record.toIssue()));
        // notifyListeners();
      // });
    // });
  }

  final Future<FlutterDatabase> database = $FloorFlutterDatabase.databaseBuilder('database.db').build();
  final List<Issue> issues = [];

  void addIssue(Issue issue) {
    // database.then((database) => database.issuesDao.insert(IssueRecord.fromIssue(issue)));
    issues.add(issue);
    notifyListeners();
  }

  void removeIssue(Issue issue) {
    issues.remove(issue);
    notifyListeners();
  }

  void reorderIssues(int oldPosition, int newPosition) {
    issues.insert(min(newPosition, issues.length - 1), issues.removeAt(oldPosition));
    notifyListeners();
  }
}
