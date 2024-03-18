import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_docs_clone/features/documents/models/document.dart';
import 'package:google_docs_clone/features/documents/repository/document_repo.dart';

part 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  final DocumentRepository _docsRepository;

  DocumentsCubit(this._docsRepository) : super(DocumentsInitial());

  void setDocuments(List<Document> documents) {
    emit(DocumentsLoaded(documents));
  }

  void getUserDocuments(String token) async {
    try {
      final documents = await _docsRepository.getUserDocuments(token);
      emit(DocumentsLoaded(documents));
    } catch (e) {
      emit(DocumentsError(e.toString()));
    }
  }

  void getDocument(String id, String token) async {
    emit(DocumentsLoading());
    try {
      final document = await _docsRepository.getDocument(id: id, token: token);
      // emit(DocumentLoaded(document));
    } catch (e) {
      emit(DocumentsError(e.toString()));
    }
  }

  void createDocument(String token) async {
    List<Document> documents = [];
    if (state is DocumentsLoaded) {
      documents = (state as DocumentsLoaded).documents;
    }
    emit(DocumentsLoading());
    try {
      final document = await _docsRepository.createDocument(token);
      print('Document Created$document');
      documents.add(document);
      emit(DocumentCreated(document: document));
      emit(DocumentsLoaded(documents));
    } catch (e) {
      print('Creating Document Error$e');
      emit(DocumentsError(e.toString()));
    }
  }

  void updateDocumentTitle(String token, String docId, String title) {
    final update = {'title': title};
    _docsRepository.updateDocumentContent(docId, update, token);
  }
}
