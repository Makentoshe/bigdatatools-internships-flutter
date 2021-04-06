import 'package:bigdatatools_internships/screen/issues/model/issue.dart';
import 'package:bigdatatools_internships/screen/issues/model/tag.dart';
import 'package:floor/floor.dart';

@entity
class IssueRecord {
  IssueRecord(this.summary, this.description, this.id, this.order);

  IssueRecord.fromIssue(Issue issue)
      : summary = issue.summary,
        description = issue.description,
        order = issue.order,
        id = issue.id;

  IssueRecord.fromOrderedIssueFactory(OrderedIssueFactory factory)
      : summary = factory.summary,
        description = factory.description,
        order = factory.order,
        id = null;

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int order;
  final String summary;
  final String description;

  Issue toIssue(List<Tag> tags) {
    return Issue(summary, description, tags, id!, order);
  }

  @override
  String toString() {
    return 'IssueRecord(id:$id, order:$order, summary:$summary, description:$description)';
  }
}
