// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:google_docs_clone/config/app_config.dart';
import 'package:google_docs_clone/core/repository/http_client.dart';

import 'package:google_docs_clone/features/documents/models/document.dart';

class DocumentRepository {
  final HttpClient _client;

  DocumentRepository({
    required HttpClient client,
  }) : _client = client;

  Future<List<Document>> getUserDocuments(String token) async {
    final response =
        await _client.get(AppConfig.getUserDocuments, token: token);

    return List<Document>.from(
      jsonDecode(response).map(
        (x) => Document.fromMap(x),
      ),
    );
  }

  Future<Document> getDocument(
      {required String id, required String token}) async {
    final response = await _client.get(AppConfig.getDocument(id), token: token);

    return Document.fromJson(response);
  }

  Future<Document> createDocument(String token) async {
    final response = await _client.post(
      AppConfig.createDocument,
      token: token,
      body: {
        'title': 'Untitled Document',
      },
    );

    return Document.fromJson(response);
  }

  Future<Document> updateDocumentContent(
      String docId, Map<String, dynamic> update, String token) async {
    final response = await _client.patch(
      AppConfig.updateDocument(docId),
      token: token,
      body: update,
    );

    return Document.fromJson(response);
  }

  Future<void> deleteDocument(String id, String token) async {
    await _client.delete(AppConfig.deleteDocument(id), token: token);
  }
}
