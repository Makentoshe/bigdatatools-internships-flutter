import 'package:bigdatatools_internships/screen/issues/model/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class IssueCreateTagDialogWidget extends StatefulWidget {
  IssueCreateTagDialogWidget(this.issueTagsController, {Key? key}) : super(key: key);

  final TextEditingController issueTagsController;

  @override
  State<StatefulWidget> createState() => IssueCreateTagDialogWidgetState(issueTagsController);
}

class IssueCreateTagDialogWidgetState extends State<IssueCreateTagDialogWidget> {
  IssueCreateTagDialogWidgetState(this.issueTagsController) : super();

  final TextEditingController issueTagsController;

  Color? selectedColor;
  final List<Color> availableColors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black,
    Colors.purple,
    Colors.brown,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a tag'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text('Title (require)'),
            ),
            TextField(
              keyboardType: TextInputType.name,
              controller: issueTagsController,
              decoration: InputDecoration(border: UnderlineInputBorder(), hintText: "Type a tag"),
              onChanged: (text) {
                setState(() {});
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 32.0),
              alignment: Alignment.topLeft,
              child: Text('Pick a tag color'),
            ),
            Container(
              height: 128,
              child: BlockPicker(
                pickerColor: Colors.grey.shade500,
                availableColors: availableColors,
                onColorChanged: changeColor,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Apply'),
          onPressed: issueTagsController.text.isEmpty
              ? null
              : () {
                  Navigator.pop(context, TagFactory(issueTagsController.text, color: selectedColor));
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

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }
}
