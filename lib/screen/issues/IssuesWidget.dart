import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CreateIssueWidget.dart';
import 'model/Issue.dart';

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
        child: ListView.builder(
          itemCount: issues.length,
          itemBuilder: (context, position) => listViewItem(context, position, issues[position]),
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

  listViewItem(BuildContext context, int position, Issue issue) {
    return Card(
      margin: const EdgeInsets.only(left: 8, top: 10, right: 8),
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
}
