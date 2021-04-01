import 'package:bigdatatools_internships/CreateIssueWidget.dart';
import 'package:flutter/material.dart';

class IssuesWidget extends StatefulWidget {
  IssuesWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  IssuesWidgetState createState() => IssuesWidgetState();
}

class IssuesWidgetState extends State<IssuesWidget> {

  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, position) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(position.toString(),),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateIssueWidget())
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
