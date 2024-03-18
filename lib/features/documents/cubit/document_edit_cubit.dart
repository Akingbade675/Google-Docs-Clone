// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_docs_clone/core/repository/socket_repo.dart';
import 'package:google_docs_clone/features/documents/models/document.dart';
import 'package:google_docs_clone/features/documents/repository/document_repo.dart';

part 'document_edit_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  final DocumentRepository _docsRepository;
  final SocketRepository _socketRepository = SocketRepository();

  DocumentCubit(this._docsRepository) : super(DocumentLoading());

  void joinDocument(String docId) async {
    emit(DocumentLoading());
    try {
      _socketRepository.connectAndJoin(docId: docId);
      emit(DocumentJoined());
    } catch (e) {
      print('Joining Document Error$e');
    }
  }

  void getDocument(String docId, String token) async {
    emit(DocumentLoading());
    try {
      final document =
          await _docsRepository.getDocument(id: docId, token: token);
      emit(DocumentLoaded(document));
    } catch (e) {
      emit(DocumentError(e.toString()));
    }
  }

  void createDocument(String token) async {
    emit(DocumentLoading());
    try {
      final document = await _docsRepository.createDocument(token);
      print('Document Created$document');
      emit(DocumentLoaded(document));
    } catch (e) {
      print('Creating Document Error$e');
      emit(DocumentError(e.toString()));
    }
  }

  void updateDocumentTitle(String token, String docId, String title) {
    final update = {'title': title};
    _docsRepository.updateDocumentContent(docId, update, token);
  }

  void updateDocumentContent(String token, String docId, String content) {
    final update = {'content': content};
    _docsRepository.updateDocumentContent(docId, update, token);
  }

  void typing(String docId, String updateDelta) {
    _socketRepository.updateDocumentContent(docId, updateDelta);
  }

  void editContentListener(Function(Map<String, dynamic>) callback) {
    _socketRepository.updateDocumentContentListener(callback);
  }
}
