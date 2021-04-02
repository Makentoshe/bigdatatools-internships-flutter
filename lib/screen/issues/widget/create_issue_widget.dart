import 'package:bigdatatools_internships/screen/issues/widget/create_issue_tag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/issue.dart';
import '../model/tag.dart';

class CreateIssueWidget extends StatefulWidget {
  CreateIssueWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateIssueWidgetState();
}

// TODO Make button aligned in bottom center. Scroll should be ends in top of the view
class CreateIssueWidgetState extends State<CreateIssueWidget> {
  final issueSummaryController = TextEditingController();
  final issueDescriptionController = TextEditingController();
  final issueTagsController = TextEditingController();

  final List<Tag> issueTags = <Tag>[];
  var issueTagsVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Issue")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              alignment: Alignment.topLeft,
              child: Text('Summary (require)'),
            ),
            Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: issueSummaryController,
                  maxLines: null,
                  decoration: InputDecoration(border: UnderlineInputBorder(), hintText: "Type an issue summary"),
                  onChanged: (text) {
                    setState(() {});
                  },
                )),
            Container(
              padding: EdgeInsets.only(left: 16.0, top: 32.0, right: 16.0),
              alignment: Alignment.topLeft,
              child: Text('Description'),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: issueDescriptionController,
                maxLines: null,
                decoration: InputDecoration(border: UnderlineInputBorder(), hintText: "Type an issue description"),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0, top: 32.0, right: 16.0),
              alignment: Alignment.topLeft,
              child: Text('Tags'),
            ),
            Visibility(
              visible: issueTagsVisibility,
              child: Container(
                height: 32,
                margin: EdgeInsets.only(top: 8.0),
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: issueTags.length,
                  itemBuilder: (context, position) => buildItem(context, issueTags[position]),
                  separatorBuilder: (BuildContext context, int index) => buildSeparator(context),
                ),
              ),
            ),
            Visibility(
              visible: !issueTagsVisibility,
              child: Container(
                alignment: Alignment.centerLeft,
                height: 32,
                margin: EdgeInsets.only(left: 16.0, top: 8.0),
                child: GestureDetector(
                  onTap: () => showTagPickerDialog(),
                  child: RawChip(
                    label: Text('No tags'),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 16, top: 32.0, right: 16, bottom: 16),
                width: double.infinity,
                child: ElevatedButton(
                    child: Text('Add issue'),
                    onPressed: issueSummaryController.text.isEmpty
                        ? null
                        : () {
                            final issue = Issue(
                                summary: issueSummaryController.text,
                                description: issueDescriptionController.text,
                                tags: issueTags);
                            Navigator.pop(context, issue);
                          }),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildItem(BuildContext context, Tag tag) {
    return Container(
      child: RawChip(
        label: Text(tag.title),
        deleteIcon: Icon(Icons.close, size: 24.0),
        onDeleted: () => removeTag(tag),
      ),
    );
  }

  buildSeparator(BuildContext context) {
    return Container(margin: EdgeInsets.only(left: 4.0, right: 4.0));
  }

  removeTag(Tag tag) {
    setState(() {
      issueTags.remove(tag);
      issueTagsVisibility = issueTags.isNotEmpty;
    });
  }

  addTag(Tag tag) {
    setState(() {
      issueTags.add(tag);
      issueTagsVisibility = issueTags.isNotEmpty;
    });
  }

  Future showTagPickerDialog() async {
    return showDialog<Tag>(
      context: context,
      builder: (BuildContext context) => CreateIssueTagWidget(issueTagsController),
    ).then((value) {
      if (value != null) addTag(value);
    });
  }

  @override
  void dispose() {
    issueSummaryController.dispose();
    issueDescriptionController.dispose();
    issueTagsController.dispose();
    super.dispose();
  }
}
