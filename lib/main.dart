import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_docs_clone/config/app_strings.dart';
import 'package:google_docs_clone/features/authentication/bloc/cubit/auth_cubit.dart';
import 'package:google_docs_clone/features/authentication/presentation/signin_screen.dart';
import 'package:google_docs_clone/features/authentication/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (_) => AuthRepository(
          googleSignIn: GoogleSignIn(
              // clientId:
              //     '469936654842-r1f8k49ps1kt2988nuse2nuhqsq6g7bn.apps.googleusercontent.com',
              // scopes: [
              //   'email',
              //   'https://www.googleapis.com/auth/contacts.readonly',
              // ],
              )),
      child: BlocProvider(
        create: (context) => AuthCubit(
          RepositoryProvider.of<AuthRepository>(context),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
