import 'package:bigdatatools_internships/screen/issues/model/tag.dart';
import 'package:flutter/material.dart';

class CreateIssueTagWidget extends StatefulWidget {

  final TextEditingController issueTagsController;

  CreateIssueTagWidget(this.issueTagsController, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateIssueTagWidgetState(issueTagsController);
}


class CreateIssueTagWidgetState extends State<CreateIssueTagWidget> {

  final TextEditingController issueTagsController;

  CreateIssueTagWidgetState(this.issueTagsController): super();

  final List<Tag> issueTags = <Tag>[];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a tag'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.name,
              controller: issueTagsController,
              decoration: InputDecoration(border: UnderlineInputBorder(), hintText: "Type a tag"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Apply'),
          onPressed: () {
            Navigator.pop(context, Tag(title: issueTagsController.text));
            issueTagsController.clear();
          },
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
            issueTagsController.clear();
          },
        )
      ],
    );
  }

}
