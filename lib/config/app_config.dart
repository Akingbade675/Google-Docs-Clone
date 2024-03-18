class AppConfig {
  static const baseUrl = 'http://$ipAddress:3000/';
  static const ipAddress = '192.168.43.37';
  // static const ipAddress = '10.0.2.2';
  // static const ipAddress = 'localhost';

  static const socketUrl = '${baseUrl}document';

  static const getUserDocuments = 'document/u';
  static updateDocument(String id) => 'document/d/$id/edit';

  static const createDocument = 'document';
  static getDocument(String id) => 'document/$id';

  static deleteDocument(String id) => 'document/$id';
}
