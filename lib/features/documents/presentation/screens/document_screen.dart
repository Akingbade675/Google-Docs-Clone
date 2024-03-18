import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_docs_clone/features/authentication/bloc/cubit/auth_cubit.dart';
import 'package:google_docs_clone/features/documents/cubit/document_edit_cubit.dart';
import 'package:routemaster/routemaster.dart';

class DocumentScreen extends StatefulWidget {
  final String? id;
  final String? title;

  const DocumentScreen({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  late final String _token;

  @override
  void initState() {
    super.initState();
    _token = (context.read<AuthCubit>() as AuthAuthenticated).user.token;

    if (widget.id == null) {
      context.read<DocumentCubit>().createDocument(_token);
    } else {
      context.read<DocumentCubit>().getDocument(widget.id!, _token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is DocumentError) {
        } else if (state is DocumentLoaded) {
          final doc = state.document;
          Routemaster.of(context)
              .replace('document/d/${doc.id}/edit', queryParameters: {
            'document': doc.toJson(),
            'readOnly': (widget.id == null ? false : true).toString()
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? 'Untitled Document'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
