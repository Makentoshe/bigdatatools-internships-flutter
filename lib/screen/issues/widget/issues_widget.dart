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
          itemBuilder: (context, position) => buildItem(context, issues[position], null),
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

  buildItem(BuildContext context, Issue issue, double elevation) {
    return GestureDetector(
      key: Key(issue.summary),
      onTap: () => tapItem(issue),
      child: buildCardItem(context, issue, elevation),
    );
  }

  buildCardItem(BuildContext context, Issue issue, double elevation) {
    return Card(
      elevation: elevation,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 0),
              child: Text(
                issue.summary,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
              child: Text(
                issue.description,
                style: TextStyle(fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
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

  tapItem(Issue issue) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                buildCardItem(context, issue, 0.0),
                const Divider(
                  color: Colors.purpleAccent,
                  thickness: 1,
                ),
                ListTile(
                  title: Text('Change issue'),
                ),
                ListTile(
                  title: Text('Delete issue', style: TextStyle(color: Colors.redAccent)),
                  onTap: () => showItemDeleteDialog(issue),
                )
              ],
            ),
          );
        });
  }

  Future<void> showItemDeleteDialog(Issue issue) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete this issue?'),
            actions: [
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  removeIssue(issue);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
