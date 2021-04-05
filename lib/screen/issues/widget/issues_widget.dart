import 'dart:math';

import 'package:bigdatatools_internships/screen/issues/model/issue_action.dart';
import 'package:bigdatatools_internships/screen/issues/viewmodel/issues_view_model.dart';
import 'package:bigdatatools_internships/screen/issues/widget/issue_item_action_dialog_widget.dart';
import 'package:bigdatatools_internships/screen/issues/widget/issue_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/issue.dart';
import '../model/tag.dart';
import 'issue_create_widget.dart';

class IssuesWidget extends StatefulWidget {
  IssuesWidget(this.title, this.viewModel, {Key? key}) : super(key: key);

  final String title;
  final IssuesViewModel viewModel;

  @override
  IssuesWidgetState createState() => IssuesWidgetState(viewModel);
}

class IssuesWidgetState extends State<IssuesWidget> {
  IssuesWidgetState(this.viewModel) : super() {
    viewModel.addListener(() {
      setState(() {});
    });
  }

  final IssuesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView.builder(
          itemCount: viewModel.issues.length,
          itemBuilder: (context, position) => buildIssueItem(context, viewModel.issues[position], 1.0),
          onReorder: (start, current) => viewModel.reorderIssues(start, current),
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
    if (result is Issue) viewModel.addIssue(result);
  }

  showIssueActionsBottomDialog(Issue issue) {
    showModalBottomSheet(context: context, builder: (BuildContext context) => IssueItemActionDialogWidget(issue))
        .then((action) => issueAction(action));
  }

  issueAction(IssueAction action) {
    switch (action.runtimeType) {
      case DeleteIssueAction:
        {
          issueActionDelete(action as DeleteIssueAction);
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
    viewModel.removeIssue(action.issue);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }
}
