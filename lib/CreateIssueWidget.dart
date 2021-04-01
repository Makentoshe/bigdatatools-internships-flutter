import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateIssueWidget extends StatefulWidget {
  CreateIssueWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateIssueWidgetState();
}

// TODO fix layout scroll and button
// TODO add backward navigation
// TODO pass a created issue data through navigation
class CreateIssueWidgetState extends State<CreateIssueWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Issue")),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                padding: EdgeInsets.only(
                    left: 16.0, top: 10.0, right: 16.0, bottom: 0.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Type an issue summary"),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
              width: double.infinity,
              child: ElevatedButton(
                  child: Text('Add issue'),
                  onPressed: () => {}),
            ),
          ),
        ],
      ),
    );
  }
}
