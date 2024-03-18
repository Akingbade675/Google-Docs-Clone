// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'documents_cubit.dart';

sealed class DocumentsState extends Equatable {
  const DocumentsState();

  @override
  List<Object> get props => [];
}

final class DocumentsInitial extends DocumentsState {}

final class DocumentsLoading extends DocumentsState {}

class DocumentCreated extends DocumentsState {
  final Document document;

  const DocumentCreated({
    required this.document,
  });

  DocumentCreated copyWith({
    Document? document,
  }) {
    return DocumentCreated(
      document: document ?? this.document,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'document': document.toMap(),
    };
  }

  factory DocumentCreated.fromMap(Map<String, dynamic> map) {
    return DocumentCreated(
      document: Document.fromMap(map['document'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentCreated.fromJson(String source) =>
      DocumentCreated.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [document];
}

class DocumentsLoaded extends DocumentsState {
  final List<Document> documents;

  const DocumentsLoaded(this.documents);

  @override
  List<Object> get props => [documents];

  DocumentsLoaded copyWith({
    List<Document>? documents,
  }) {
    return DocumentsLoaded(
      documents ?? this.documents,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documents': documents.map((x) => x.toMap()).toList(),
    };
  }

  factory DocumentsLoaded.fromMap(Map<String, dynamic> map) {
    return DocumentsLoaded(
      List<Document>.from(
        (map['documents'] as List<int>).map<Document>(
          (x) => Document.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentsLoaded.fromJson(String source) =>
      DocumentsLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

final class DocumentsError extends DocumentsState {
  final String message;

  const DocumentsError(this.message);

  @override
  List<Object> get props => [message];
}
