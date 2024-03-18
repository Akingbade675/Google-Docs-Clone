import 'package:flutter/material.dart';
import 'package:google_docs_clone/features/authentication/presentation/signin_screen.dart';
import 'package:google_docs_clone/features/authentication/presentation/splash_screen.dart';
import 'package:google_docs_clone/features/documents/models/document.dart';
import 'package:google_docs_clone/features/documents/presentation/screens/document_edit_screen.dart';
import 'package:google_docs_clone/features/documents/presentation/screens/document_screen.dart';
import 'package:google_docs_clone/features/documents/presentation/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

class AppRoutes {
  static final loadingRoute = RouteMap(routes: {
    '/main': (_) => const MaterialPage(child: SplashScreen()),
    '/': (_) => const MaterialPage(child: HomeScreen()),
    '/doc': (route) {
      return MaterialPage(
        child: DocumentEditScreen(
          id: 'clnlv1lsk0005wf9s9x9qls4m',
          document: Document(
            id: 'clnlv1lsk0005wf9s9x9qls4m',
            title: 'Untitled Document',
            authorId: '1',
            createdAt: DateTime.parse('2021-09-30T12:00:00.000Z'),
            openedAt: DateTime.parse('2021-09-30T12:00:00.000Z'),
          ),
        ),
      );
    },
  });

  static final authenticatedRoutes = RouteMap(
    routes: {
      '/': (_) => const MaterialPage(child: HomeScreen()),
      // '/document/u': (_) => const MaterialPage(child: HomeScreen()),
      // 'profile': (_) => const MaterialPage(child: ProfileScreen()),
      // 'settings': (_) => const MaterialPage(child: SettingsScreen()),
      // 'documents': (_) => const MaterialPage(child: DocumentsScreen()),
      'document/d/:id': (route) {
        final id = route.pathParameters['id'];
        final title = route.queryParameters['title'];
        return MaterialPage(
          child: DocumentScreen(
            id: id!,
            title: title!,
          ),
        );
      },
      '/document/d/:id/edit': (route) {
        final id = route.pathParameters['id'];
        final document = route.queryParameters['document'];
        final readOnly = route.queryParameters['readOnly'];
        return MaterialPage(
          child: DocumentEditScreen(
            id: id!,
            readOnly: readOnly == null ? false : bool.tryParse(readOnly)!,
            document: Document.fromJson(document!),
          ),
        );
      },
      'document/new': (_) => const MaterialPage(child: DocumentScreen()),
      // 'documents/:id/share': (route) {
      //   final id = route.pathParameters['id'];
      //   return MaterialPage(
      //     child: DocumentShareScreen(
      //       id: id,
      //     ),
      //   );
      // },
      // 'documents/:id/permissions': (route) {
      //   final id = route.pathParameters['id'];
      //   return MaterialPage(
      //     child: DocumentPermissionsScreen(
      //       id: id,
      //     ),
      //   );
      // },
      // 'documents/:id/permissions/new': (route) {
      //   final id = route.pathParameters['id'];
      //   return MaterialPage(
      //     child: DocumentPermissionsNewScreen(
      //       id: id,
      //     ),
      //   );
      // },
      // 'documents/:id/permissions/:permissionId': (route) {
      //   final id = route.pathParameters['id'];
      //   final permissionId = route.pathParameters['permissionId'];
      //   return MaterialPage(
      //     child: DocumentPermissionsEditScreen(
      //       id: id,
      //       permissionId: permissionId,
      //     ),
      //   );
      // },
      // 'documents/:id/permissions/:permissionId/delete': (route) {
      //   final id = route.pathParameters['id'];
      //   final permissionId = route.pathParameters['permissionId'];
      //   return MaterialPage(
      //     child: DocumentPermissionsDeleteScreen(
      //       id: id,
      //       permissionId: permissionId,
      //     ),
      //   );
      // },
    },
  );

  static final unauthenticatedRoutes = RouteMap(
    routes: {
      '/': (_) => const MaterialPage(
            child: SignInScreen(),
          ),
      // 'signin': (_) => const MaterialPage(child: SignInScreen()),
      // 'signup': (_) => const MaterialPage(child: SignUpScreen()),
      // 'forgot-password': (_) => const MaterialPage(child: ForgotPasswordScreen()),
    },
  );
}
