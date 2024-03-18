import 'package:google_docs_clone/core/repository/socket_client.dart';

class SocketRepository {
  final _socketClient = SocketClient.instance;

  Future<void> connectAndJoin({
    required String docId,
    String? token,
  }) async {
    _socketClient.connect(onConnect: () {
      joinDocument(docId, token);
    });
  }

  void send(String event, dynamic message) {
    _socketClient.send(event, message);
  }

  void listen(String event, Function(dynamic) callback) {
    _socketClient.listen(event, callback);
  }

  void close() {
    _socketClient.close();
  }

  void joinDocument(String docId, String? token) {
    send('join', docId);
  }

  void updateDocumentContent(String docId, String delta) {
    send('messageDocumentEditContent', {'docId': docId, 'delta': delta});
  }

  void updateDocumentContentListener(Function(Map<String, dynamic>) callback) {
    listen('messageDocumentEditContent', (data) => callback(data));
  }

  void updateDocumentTitle(String docId, String token, String title) {
    send('update', {'docId': docId, 'token': token, 'title': title});
  }

  void updateDocumentSelection(String docId, String token, String selection) {
    send('update', {'docId': docId, 'token': token, 'selection': selection});
  }

  void updateDocumentCursor(String docId, String token, String cursor) {
    send('update', {'docId': docId, 'token': token, 'cursor': cursor});
  }
}
