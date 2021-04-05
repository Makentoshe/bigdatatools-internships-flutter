import 'package:flutter/material.dart';
import 'issues/viewmodel/issues_view_model.dart';
import 'issues/widget/issues_widget.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JetBrains BDT Inspector',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: IssuesWidget(title: 'Flutter To-Do list', viewModel: IssuesViewModel(),),
    );
  }
}
