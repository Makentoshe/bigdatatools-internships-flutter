import 'dart:math';

import 'package:bigdatatools_internships/database/database.dart';
import 'package:bigdatatools_internships/database/record/issue_record.dart';
import 'package:bigdatatools_internships/database/record/tag_record.dart';
import 'package:bigdatatools_internships/screen/issues/model/issue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IssuesViewModel extends ChangeNotifier {
  IssuesViewModel() {
    database.then((database) {
      database.issuesDao.getAll().then((issueRecords) {
        issueRecords.sort((a, b) => a.order.compareTo(b.order));
        issueRecords.forEach((issueRecord) {
          database.tagsDao.getAllByIssueId(issueRecord.id!).then((tagRecords) {
            this.issues.add(issueRecord.toIssue(tagRecords.map((tagRecord) => tagRecord.toTag()).toList()));
            notifyListeners();
          });
        });
      });
    });
  }

  final Future<FlutterDatabase> database = $FloorFlutterDatabase.databaseBuilder('database.db').build();
  final List<Issue> issues = [];

  void addIssue(IssueFactory factory) {
    final orderedIssueFactory = factory.order(issues.length);
    final issueRecord = IssueRecord.fromOrderedIssueFactory(orderedIssueFactory);
    database.then(
      (database) => database.issuesDao.insert(issueRecord).then((issueId) {
        issues.add(orderedIssueFactory.build(issueId));
        orderedIssueFactory.tags.forEach((tagFactory) {
          database.tagsDao.insert(TagRecord.fromTagFactory(tagFactory, issueId));
        });
        notifyListeners();
      }),
    );
  }

  void removeIssue(Issue issue) {
    database.then((database) {
      database.tagsDao.removeByIssueId(issue.id);
      database.issuesDao.remove(issue.id).then((ignore) {
        issues.remove(issue);
        notifyListeners();
      });
    });
  }

  void reorderIssues(int oldPosition, int newPosition) {
    if (oldPosition < newPosition) {
      _internalReorderIssuesA(oldPosition, newPosition);
    } else {
      _internalReorderIssuesB(oldPosition, newPosition);
    }
    notifyListeners();
  }

  void _internalReorderIssuesA(int oldPosition, int newPosition) {
    database.then((database) {
      issues.insert(min(newPosition - 1, issues.length - 1), issues.removeAt(oldPosition));
      issues.sublist(oldPosition, newPosition).forEach((issue) {
        database.issuesDao.update(IssueRecord.fromIssue(issue.copy(order: issues.indexOf(issue))));
      });
    });
  }

  void _internalReorderIssuesB(int oldPosition, int newPosition) {
    database.then((database) {
      issues.insert(min(newPosition, issues.length - 1), issues.removeAt(oldPosition));
      issues.sublist(newPosition, oldPosition + 1).forEach((issue) {
        database.issuesDao.update(IssueRecord.fromIssue(issue.copy(order: issues.indexOf(issue))));
      });
    });
  }
}
