// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'document_edit_cubit.dart';

sealed class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object> get props => [];
}

final class DocumentInitial extends DocumentState {}

final class DocumentLoading extends DocumentState {}

class DocumentLoaded extends DocumentState {
  final Document document;

  const DocumentLoaded(
    this.document,
  );

  DocumentLoaded copyWith({
    Document? document,
  }) {
    return DocumentLoaded(
      document ?? this.document,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'document': document.toMap(),
    };
  }

  factory DocumentLoaded.fromMap(Map<String, dynamic> map) {
    return DocumentLoaded(
      Document.fromMap(map['document'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentLoaded.fromJson(String source) =>
      DocumentLoaded.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [document];
}

final class DocumentJoined extends DocumentState {}

final class DocumentError extends DocumentState {
  final String message;

  const DocumentError(this.message);

  @override
  List<Object> get props => [message];
}
