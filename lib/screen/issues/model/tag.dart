import 'package:flutter/material.dart';

class Tag {
  Tag(this.id, this.title, {this.color});

  final int id;
  final String title;
  final Color? color;

  @override
  String toString() {
    return 'Tag(id:$id, title:$title, color:$color)';
  }
}

class TagFactory {
  TagFactory(this.title, {this.color});

  final String title;
  final Color? color;

  Tag build(int id) {
    return Tag(id, title, color: color);
  }

  @override
  String toString() {
    return 'TagFactory(title:$title, color:$color)';
  }
}
