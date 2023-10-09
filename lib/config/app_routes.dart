import 'package:flutter/material.dart';
import 'package:google_docs_clone/features/authentication/presentation/home_screen.dart';
import 'package:google_docs_clone/features/authentication/presentation/signin_screen.dart';
import 'package:routemaster/routemaster.dart';

class AppRoutes {
  static final authenticatedRoutes = RouteMap(
    routes: {
      'document/u': (_) => const MaterialPage(child: HomeScreen()),
      // 'profile': (_) => const MaterialPage(child: ProfileScreen()),
      // 'settings': (_) => const MaterialPage(child: SettingsScreen()),
      // 'documents': (_) => const MaterialPage(child: DocumentsScreen()),
      // 'documents/:id': (route) {
      //   final id = route.pathParameters['id'];
      //   return MaterialPage(
      //     child: DocumentScreen(
      //       id: id,
      //     ),
      //   );
      // },
      // 'documents/:id/edit': (route) {
      //   final id = route.pathParameters['id'];
      //   return MaterialPage(
      //     child: DocumentEditScreen(
      //       id: id,
      //     ),
      //   );
      // },
      // 'documents/new': (_) => const MaterialPage(child: DocumentNewScreen()),
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
