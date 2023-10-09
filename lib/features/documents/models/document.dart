// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final String id;
  final List<String> content;
  final String authorId;
  final DateTime createdAt;
  final DateTime openedAt;

  const Document({
    required this.id,
    required this.content,
    required this.authorId,
    required this.createdAt,
    required this.openedAt,
  });

  Document copyWith({
    String? id,
    List<String>? content,
    String? authorId,
    DateTime? createdAt,
    DateTime? openedAt,
  }) {
    return Document(
      id: id ?? this.id,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      openedAt: openedAt ?? this.openedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'authorId': authorId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'openedAt': openedAt.millisecondsSinceEpoch,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] as String,
      content: List<String>.from((map['content'] as List<String>)),
      authorId: map['authorId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      openedAt: DateTime.fromMillisecondsSinceEpoch(map['openedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Document(id: $id, content: $content, authorId: $authorId, createdAt: $createdAt, openedAt: $openedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      content,
      authorId,
      createdAt,
      openedAt,
    ];
  }
}
