
import 'package:bigdatatools_internships/screen/issues/model/issue.dart';
import 'package:bigdatatools_internships/screen/issues/model/issue_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IssueItemActionDeleteDialogWidget extends StatelessWidget {
  IssueItemActionDeleteDialogWidget(this.issue): super();

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete this issue?'),
      actions: [
        TextButton(
          child: Text('Delete'),
          onPressed: () => Navigator.pop(context, DeleteIssueAction(issue)),
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }


}