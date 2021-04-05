import 'tag.dart';

class Issue {
  Issue(this.summary, this.description, this.tags, [this.id = -1]);

  final int id;
  final String summary;
  final String description;
  final List<Tag> tags;

  Issue copy({int? id, String? summary, String? description, List<Tag>? tags}) {
    return Issue(summary ?? this.summary, description ?? this.description, tags ?? this.tags, id ?? this.id);
  }
}
