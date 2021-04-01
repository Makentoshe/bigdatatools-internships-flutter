import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create_issue_widget.dart';
import '../model/issue.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView.builder(
          itemCount: issues.length,
          itemBuilder: (context, position) => buildItem(context, position, issues[position]),
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

  buildItem(BuildContext context, int position, Issue issue) {
    return Card(
      key: Key(issue.summary),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          issue.summary,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
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
}
