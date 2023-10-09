import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_docs_clone/config/app_routes.dart';
import 'package:google_docs_clone/config/app_strings.dart';
import 'package:google_docs_clone/core/repository/http_client.dart';
import 'package:google_docs_clone/features/authentication/bloc/cubit/auth_cubit.dart';
import 'package:google_docs_clone/features/authentication/presentation/signin_screen.dart';
import 'package:google_docs_clone/features/authentication/repository/auth_repository.dart';
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              RepositoryProvider.of<AuthRepository>(context),
            ),
          )
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
    context.read<AuthCubit>().appStarted();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: AppStrings.appName,
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
                return AppRoutes.authenticatedRoutes;
              case AuthUnauthenticated:
                return AppRoutes.unauthenticatedRoutes;
              default:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((authState as AuthError).message),
                  ),
                );
                return AppRoutes.unauthenticatedRoutes;
            }
          },
        )
        // home: const SignInScreen(),
        );
  }
}
