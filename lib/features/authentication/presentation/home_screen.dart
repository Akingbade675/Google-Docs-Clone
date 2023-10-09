import 'package:flutter/material.dart';
import 'package:google_docs_clone/features/authentication/models/user_model.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(user.id),
            Text(user.email),
            Text(user.name),
            Text(user.photoUrl),
          ],
        ),
      ),
    );
  }
}
