import 'tag.dart';

class Issue {
  Issue(this.summary, this.description, this.tags, this.id, this.order);

  final int id;
  final String summary;
  final String description;
  final List<Tag> tags;
  final int order;

  Issue copy({int? id, String? summary, String? description, List<Tag>? tags, int? order}) {
    return Issue(
      summary ?? this.summary,
      description ?? this.description,
      tags ?? this.tags,
      id ?? this.id,
      order ?? this.order,
    );
  }

  @override
  String toString() {
    return 'Issue(id:$id, order:$order, summary:$summary, description:$description, tags:[${tags.join(", ")}])';
  }
}

class IssueFactory {
  IssueFactory(this.summary, this.description, this.tags);

  final String summary;
  final String description;
  final List<TagFactory> tags;

  OrderedIssueFactory order(int order) {
    return OrderedIssueFactory(summary, description, tags, order);
  }
}

class OrderedIssueFactory {
  OrderedIssueFactory(this.summary, this.description, this.tags, this.order);

  final String summary;
  final String description;
  final List<TagFactory> tags;
  final int order;

  Issue build(int id) {
    return Issue(summary, description, tags.map((factory) => factory.build(-1)).toList(), id, order);
  }
}
