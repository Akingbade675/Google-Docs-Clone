import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_docs_clone/config/app_icons.dart';
import 'package:google_docs_clone/features/authentication/bloc/cubit/auth_cubit.dart';
import 'package:google_docs_clone/features/authentication/presentation/home_screen.dart';
import 'package:google_docs_clone/styles/app_colors.dart';
import 'package:routemaster/routemaster.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Routemaster.of(context).replace('/document/u');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<AuthCubit>().signIn();
            },
            icon: SvgPicture.asset(
              AppIcons.icGoogle,
              width: 20,
              height: 20,
            ),
            label: const Text(
              'Sign in with Google',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.white,
              foregroundColor: AppColor.grey,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
