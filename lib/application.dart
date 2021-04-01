import 'package:flutter/material.dart';
import 'screen/issues/widget/issues_widget.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JetBrains DBT Inspector',
      theme: ThemeData(
        // TODO add material color
        primarySwatch: Colors.purple,
      ),
      home: IssuesWidget(title: 'Flutter Demo Page'),
    );
  }
}
