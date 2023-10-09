import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_docs_clone/config/app_icons.dart';
import 'package:google_docs_clone/features/authentication/bloc/cubit/auth_cubit.dart';
import 'package:google_docs_clone/styles/app_colors.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final plugIn = GoogleSignInPlugin();
      plugIn.init().then((_) {
        plugIn.userDataEvents!.first.then((data) {
          // use data!.idToken! and do your stuff here
        });
      });
      return plugIn.renderButton();
    } else {
      return ElevatedButton.icon(
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
      );
    }
  }
}
