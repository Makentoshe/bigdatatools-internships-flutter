import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/issue.dart';
import '../model/tag.dart';
import 'create_issue_widget.dart';

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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Visibility(
            child: Container(
              height: 24,
              margin: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  Icon(Icons.tag, size: 16.0, color: Colors.grey.shade500),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: RichText(
                      text: TextSpan(style: TextStyle(color: Colors.grey.shade500), children: buildTagsWord(issue.tags)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextSpan buildTagWord(Tag tag) {
    return TextSpan(text: tag.title, style: TextStyle(color: tag.color));
  }

  List<TextSpan> buildTagsWord(List<Tag> tags) {
    if (tags.isEmpty) {
      return [buildTagWord(Tag(title: 'No tags'))];
    } else {
      return tags
          .map((tag) => buildTagWord(tag))
          .expand((span) => [span, TextSpan(text: ', ')])
          .toList()
          .sublist(0, tags.length * 2 - 1);
    }
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
                  title: Text('Show issue details', style: TextStyle(color: Colors.grey.shade500)),
                ),
                ListTile(
                  title: Text('Change issue', style: TextStyle(color: Colors.grey.shade500)),
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
