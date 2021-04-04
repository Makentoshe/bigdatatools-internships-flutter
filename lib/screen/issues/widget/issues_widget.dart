import 'dart:math';

import 'package:bigdatatools_internships/screen/issues/model/issue_action.dart';
import 'package:bigdatatools_internships/screen/issues/widget/issue_item_action_dialog_widget.dart';
import 'package:bigdatatools_internships/screen/issues/widget/issue_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/issue.dart';
import '../model/tag.dart';
import 'issue_create_widget.dart';

class IssuesWidget extends StatefulWidget {
  IssuesWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  IssuesWidgetState createState() => IssuesWidgetState();
}

class IssuesWidgetState extends State<IssuesWidget> {
  final List<Issue> issues = <Issue>[];

  void addIssue(Issue issue) {
    setState(() {
      issues.add(issue);
    });
  }

  void removeIssue(Issue issue) {
    setState(() {
      issues.remove(issue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView.builder(
          itemCount: issues.length,
          itemBuilder: (context, position) => buildIssueItem(context, issues[position], null),
          onReorder: (start, current) => reorderItem(start, current),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToCreateIssueWidget(context);
        },
        tooltip: 'Create issue',
        child: Icon(Icons.add),
      ),
    );
  }

  buildIssueItem(BuildContext context, Issue issue, double elevation) {
    return GestureDetector(
      key: Key(issue.summary),
      onTap: () => showIssueActionsBottomDialog(issue),
      child: IssueItemWidget(elevation, issue),
    );
  }

  navigateToCreateIssueWidget(BuildContext context) async {
    final route = MaterialPageRoute(builder: (context) => CreateIssueWidget());
    final result = await Navigator.push(context, route);
    if (result is Issue) addIssue(result);
  }

  reorderItem(int start, int current) {
    issues.insert(min(current, issues.length - 1), issues.removeAt(start));
  }

  showIssueActionsBottomDialog(Issue issue) {
    showModalBottomSheet(context: context, builder: (BuildContext context) => IssueItemActionDialogWidget(issue))
        .then((action) => issueAction(action));
  }

  issueAction(IssueAction action) {
    switch (action.runtimeType) {
      case DeleteIssueAction:
        {
          issueActionDelete(action);
          break;
        }
      case ChangeIssueAction:
        {
          break;
        }
      case DetailsIssueAction:
        {
          break;
        }
    }
  }

  issueActionDelete(DeleteIssueAction action) {
    removeIssue(action.issue);
  }
}
