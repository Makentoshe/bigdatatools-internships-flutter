import 'package:bigdatatools_internships/screen/issues/model/tag.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@entity
class TagRecord {
  TagRecord(this.id, this.issueId, this.title, this.color);

  TagRecord.fromTagFactory(TagFactory factory, this.issueId)
      : title = factory.title,
        color = factory.color?.value,
        id = null;

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int issueId;
  final String title;
  final int? color;

  Tag toTag() {
    return Tag(id!, title, color: this.color != null ? Color(color!) : null);
  }

  @override
  String toString() {
    return 'TagRecord(id:$id, issueId:$issueId, title:$title, color:$color)';
  }
}
