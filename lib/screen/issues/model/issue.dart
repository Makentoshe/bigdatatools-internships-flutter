
import 'tag.dart';

class Issue {
  Issue(this.summary, this.description, this.tags) ;

  final String summary;
  final String description;
  final List<Tag> tags;

}
