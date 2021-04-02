
import 'tag.dart';

class Issue {

  String summary;
  String description;
  List<Tag> tags;

  Issue({String summary, String description, List<Tag> tags}) {
    this.summary = summary;
    this.description = description;
    this.tags = tags;
  }

}
