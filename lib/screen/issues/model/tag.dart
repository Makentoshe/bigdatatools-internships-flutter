import 'package:flutter/material.dart';

class Tag {
  Tag(this.id, this.title, {this.color});

  final int id;
  final String title;
  final Color? color;

}

class TagFactory {
  TagFactory(this.title, {this.color});

  final String title;
  final Color? color;

  Tag build(int id) {
    return Tag(id, title, color: color);
  }
}
