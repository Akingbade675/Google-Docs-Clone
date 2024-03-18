// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final String id;
  final String title;
  final List<dynamic> content;
  final String authorId;
  final DateTime createdAt;
  final DateTime openedAt;

  const Document({
    required this.title,
    required this.id,
    this.content = const [],
    required this.authorId,
    required this.createdAt,
    required this.openedAt,
  });

  Document copyWith({
    String? id,
    String? title,
    List<dynamic>? content,
    String? authorId,
    DateTime? createdAt,
    DateTime? openedAt,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      openedAt: openedAt ?? this.openedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'createdAt': createdAt.toString(),
      'openedAt': openedAt.toString(),
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] == null
          ? []
          : List<String>.from(map['content'] as List<dynamic>),
      authorId: map['authorId'] == null ? '' : map['authorId'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      openedAt: DateTime.parse(map['openedAt'] as String),
      // openedAt: DateTime.fromMillisecondsSinceEpoch(map['openedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Document(id: $id, title: $title, content: $content, authorId: $authorId, createdAt: $createdAt, openedAt: $openedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      // content,
      authorId,
      createdAt,
      openedAt,
    ];
  }
}
