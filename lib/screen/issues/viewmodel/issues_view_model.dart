
import 'dart:math';

import 'package:bigdatatools_internships/screen/issues/model/issue.dart';
import 'package:flutter/cupertino.dart';

class IssuesViewModel extends ChangeNotifier {

  List<Issue> issues = [];

  void addIssue(Issue issue) {
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