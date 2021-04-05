import 'package:flutter/material.dart';

import '../model/issue.dart';
import '../model/tag.dart';

class IssueItemWidget extends StatelessWidget {
  IssueItemWidget(this.elevation, this.issue) : super();

  final double elevation;
  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 0),
              child: Text(
                issue.summary,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Visibility(
            child: Container(
              height: 24,
              margin: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  Icon(Icons.tag, size: 16.0, color: Colors.grey.shade500),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: RichText(
                      text: TextSpan(style: TextStyle(color: Colors.grey.shade500), children: buildTagsWord(issue.tags)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextSpan buildTagWord(Tag tag) {
    return TextSpan(text: tag.title, style: TextStyle(color: tag.color));
  }

  List<TextSpan> buildTagsWord(List<Tag> tags) {
    if (tags.isEmpty) {
      return [buildTagWord(Tag('No tags'))];
    } else {
      return tags
          .map((tag) => buildTagWord(tag))
          .expand((span) => [span, TextSpan(text: ', ')])
          .toList()
          .sublist(0, tags.length * 2 - 1);
    }
  }

}
