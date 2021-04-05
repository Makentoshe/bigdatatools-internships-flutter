import 'package:bigdatatools_internships/screen/issues/model/issue.dart';
import 'package:floor/floor.dart';

@entity
class IssueRecord {
  IssueRecord(this.summary, this.description, {this.id = -1});

  IssueRecord.fromIssue(Issue issue, {this.id = -1})
      : summary = issue.summary,
        description = issue.description;

  @PrimaryKey(autoGenerate: true)
  final int id;

  final String summary;
  final String description;

  Issue toIssue() {
    return Issue(summary, description, [], id);
  }
}
