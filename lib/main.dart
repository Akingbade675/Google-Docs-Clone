import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_docs_clone/config/app_routes.dart';
import 'package:google_docs_clone/config/app_strings.dart';
import 'package:google_docs_clone/core/repository/http_client.dart';
import 'package:google_docs_clone/features/authentication/bloc/cubit/auth_cubit.dart';
import 'package:google_docs_clone/features/authentication/repository/auth_repository.dart';
import 'package:google_docs_clone/features/documents/cubit/document_edit_cubit.dart';
import 'package:google_docs_clone/features/documents/cubit/documents_cubit.dart';
import 'package:google_docs_clone/features/documents/repository/document_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => HttpClient(client: Client()),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            googleSignIn: GoogleSignIn(),
            client: RepositoryProvider.of<HttpClient>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => DocumentRepository(
            client: RepositoryProvider.of<HttpClient>(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => DocumentsCubit(
              RepositoryProvider.of<DocumentRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => DocumentCubit(
              RepositoryProvider.of<DocumentRepository>(context),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // context.read<AuthCubit>().appStarted();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routeInformationParser: const RoutemasterParser(),
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) {
            final authState = context.watch<AuthCubit>().state;

            switch (authState.runtimeType) {
              case AuthAuthenticated:
                // context
                //     .read<DocumentsCubit>()
                //     .getUserDocuments((authState as AuthAuthenticated).user.token);
                context.read<DocumentsCubit>().setDocuments(
                      (authState as AuthAuthenticated).userDocuments,
                    );
                return AppRoutes.authenticatedRoutes;
              case AuthUnauthenticated:
                return AppRoutes.unauthenticatedRoutes;
              case AuthError:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((authState as AuthError).message),
                  ),
                );
                return AppRoutes.unauthenticatedRoutes;
              default:
                return AppRoutes.loadingRoute;
            }
          },
        )
        // home: const SignInScreen(),
        );
  }
}
