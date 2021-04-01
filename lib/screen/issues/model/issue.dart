
import 'tag.dart';

class Issue {

  String summary;
  String description;
  final List<Tag> tags = <Tag>[];

  Issue({String summary, String description}) {
    this.summary = summary;
    this.description = description;
  }

}
