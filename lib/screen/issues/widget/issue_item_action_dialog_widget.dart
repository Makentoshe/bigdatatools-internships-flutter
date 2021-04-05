import 'package:bigdatatools_internships/screen/issues/model/issue_action.dart';
import 'package:bigdatatools_internships/screen/issues/widget/issue_item_action_delete_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'issue_item_widget.dart';
import '../model/issue.dart';

class IssueItemActionDialogWidget extends StatelessWidget {
  IssueItemActionDialogWidget(this.issue) : super();

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          IssueItemWidget(0.0, issue),
          const Divider(
            color: Colors.purpleAccent,
            thickness: 1,
          ),
          ListTile(
            title: Text('Show issue details', style: TextStyle(color: Colors.grey.shade500)),
            onTap: () => Navigator.pop(context, DetailsIssueAction(issue)),
          ),
          ListTile(
            title: Text('Change issue', style: TextStyle(color: Colors.grey.shade500)),
            onTap: () => Navigator.pop(context, ChangeIssueAction(issue)),
          ),
          ListTile(
            title: Text('Delete issue', style: TextStyle(color: Colors.redAccent)),
            onTap: () => showItemDeleteDialog(context, issue).then((value) => Navigator.pop(context, value)),
          )
        ],
      ),
    );
  }

  Future<dynamic> showItemDeleteDialog(BuildContext context, Issue issue) async {
    return showDialog(context: context, builder: (BuildContext context) => IssueItemActionDeleteDialogWidget(issue));
  }
}
