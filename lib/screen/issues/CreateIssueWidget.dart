import 'package:bigdatatools_internships/screen/issues/Issue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateIssueWidget extends StatefulWidget {
  CreateIssueWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateIssueWidgetState();
}

// TODO Make button aligned in bottom center. Scroll should be ends in top of the view
class CreateIssueWidgetState extends State<CreateIssueWidget> {

  final issueSummaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Issue")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: 16.0, top: 10.0, right: 16.0, bottom: 0.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: issueSummaryController,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Type an issue summary"),
                )),
            Container(
              margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
              width: double.infinity,
              child:
                  ElevatedButton(child: Text('Add issue'), onPressed: () => {
                    Navigator.pop(context, Issue(summary: issueSummaryController.text))
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    issueSummaryController.dispose();
    super.dispose();
  }
}
