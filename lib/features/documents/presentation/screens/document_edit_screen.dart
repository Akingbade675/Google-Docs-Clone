import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:google_docs_clone/config/app_config.dart';
import 'package:google_docs_clone/features/documents/cubit/document_edit_cubit.dart';
import 'package:google_docs_clone/features/documents/cubit/documents_cubit.dart';
import 'package:google_docs_clone/features/documents/models/document.dart'
    as model;
import 'package:google_docs_clone/styles/app_colors.dart';

class DocumentEditScreen extends StatefulWidget {
  final String id;
  final bool readOnly;
  final model.Document document;

  const DocumentEditScreen({
    Key? key,
    required this.id,
    this.readOnly = false,
    required this.document,
  }) : super(key: key);

  @override
  State<DocumentEditScreen> createState() => _DocumentEditScreenState();
}

class _DocumentEditScreenState extends State<DocumentEditScreen> {
  bool readOnly = false;
  late final String _token;
  final _textController = TextEditingController();
  late final QuillController? _controller;

  @override
  void initState() {
    super.initState();
    readOnly = widget.readOnly;
    _textController.text = widget.document.title;
    // _token = (context.read<AuthCubit>() as AuthAuthenticated).user.token;
    _loadDocument();
    context.read<DocumentCubit>().joinDocument(widget.id);
    _sendLocalChanges();
    _listenForRemoteChanges();
  }

  void _sendLocalChanges() {
    _controller?.document.changes.listen((event) {
      if (event.source == ChangeSource.LOCAL) {
        final delta = jsonEncode(event.change.toJson());
        Map<String, dynamic> update = {
          'delta': delta,
          'docId': widget.id,
        };
        context.read<DocumentCubit>().typing(
              widget.id,
              delta,
            );
      }
    });
  }

  void _listenForRemoteChanges() {
    context.read<DocumentCubit>().editContentListener((data) {
      final delta = Delta.fromJson(jsonDecode(data['delta']));
      _controller?.compose(
        delta,
        _controller?.selection ?? const TextSelection.collapsed(offset: 0),
        ChangeSource.REMOTE,
      );
    });
  }

  void _loadDocument() {
    _controller = QuillController(
      document: widget.document.content.isEmpty
          ? Document()
          : Document.fromDelta(
              Delta.fromJson(widget.document.content),
            ),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentCubit, DocumentState>(
      listenWhen: (previous, current) => current is DocumentError,
      buildWhen: (previous, current) => current is! DocumentError,
      listener: (context, state) {
        final error = (state as DocumentError).message;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
      builder: (context, state) {
        return Scaffold(
            // appBar: toolBar(),
            // appBar: AppBar(
            //   title: QuillToolbar.basic(
            //     customButtons: [
            //       QuillCustomButton(
            //         icon: Icons.text_format,
            //         onTap: () {
            //           _controller?.document.undo();
            //         },
            //       ),
            //     ],
            //     sectionDividerColor: AppColor.primaryDark,
            //     controller: _controller,
            //     toolbarIconSize: 20,
            //     showFontFamily: false,
            //     showFontSize: false,
            //     showCodeBlock: false,
            //     showListCheck: false,
            //     showIndent: false,
            //     showQuote: false,
            //     showLink: false,
            //     showSearchButton: false,
            //     showSubscript: false,
            //     showSuperscript: false,
            //     showClearFormat: false,
            //     showHeaderStyle: false,
            //     showColorButton: false,
            //     showBackgroundColorButton: false,
            //     showBoldButton: false,
            //     showItalicButton: false,
            //     showUnderLineButton: false,
            //     showStrikeThrough: false,
            //     showInlineCode: false,
            //     showListBullets: false,
            //     showListNumbers: false,
            //   ),
            // ),
            appBar: readOnly ? toolBar() : editingToolBar(),
            body: Column(
              children: [
                Expanded(
                  child: Material(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: QuillEditor.basic(
                          padding: const EdgeInsets.all(30.0),
                          controller: _controller!,
                          readOnly: readOnly,
                        ),
                      ),
                    ),
                  ),
                ),
                BottomQuillToolBar(controller: _controller!),
              ],
            ),
            floatingActionButton: !readOnly
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      setState(() => readOnly = false);
                    },
                    child: const Icon(Icons.edit),
                  ));
      },
    );
  }

  AppBar toolBar() {
    return AppBar(
      title: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.document.title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'All changes saved',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar editingToolBar() {
    return AppBar(
      backgroundColor: AppColor.background,
      leading: IconButton(
        onPressed: () {
          setState(() => readOnly = true);
        },
        color: AppColor.primaryDark,
        icon: const Icon(CupertinoIcons.check_mark),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (_controller!.hasUndo) _controller?.undo();
          },
          icon: const Icon(CupertinoIcons.arrow_uturn_left),
        ),
        IconButton(
          onPressed: () {
            if (_controller!.hasRedo) _controller?.redo();
          },
          icon: const Icon(CupertinoIcons.arrow_uturn_right),
          // icon: const Icon(Icons.redo),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.textformat_alt),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.add),
          // icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.chat_bubble_text),
        ),
        PopupMenuButton(
          icon: const Icon(CupertinoIcons.ellipsis_vertical),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: TextButton.icon(
                  icon: const Icon(CupertinoIcons.pencil_outline),
                  onPressed: () {
                    Navigator.of(context).pop();
                    renameDocDialog(context);
                  },
                  label: const Text('Untitled document'),
                ),
              ),
              // Copy link
              PopupMenuItem(
                child: TextButton.icon(
                  icon: const Icon(CupertinoIcons.doc_on_clipboard),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                          text:
                              '${AppConfig.baseUrl}document/d/${widget.id}/edit'),
                    ).then(
                      (value) {
                        Navigator.of(context).pop();
                        return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            width: 200,
                            content: Text('Link copied to clipboard'),
                          ),
                        );
                      },
                    );
                  },
                  label: const Text('Copy link'),
                ),
              ),
              PopupMenuItem(
                child: TextButton.icon(
                  icon: const Icon(CupertinoIcons.trash),
                  onPressed: () {},
                  label: const Text('Delete'),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  Future<dynamic> renameDocDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.white,
        title: const Text('Rename Document'),
        content: TextField(
          controller: _textController,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop,
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              context
                  .read<DocumentsCubit>()
                  .updateDocumentTitle(_token, widget.id, _textController.text);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class BottomQuillToolBar extends StatelessWidget {
  const BottomQuillToolBar({
    super.key,
    required QuillController controller,
  }) : _controller = controller;

  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 12,
        ),
        scrollDirection: Axis.horizontal,
        child: QuillToolbar.basic(
          iconTheme: const QuillIconTheme(
            iconUnselectedFillColor: Colors.transparent,
          ),
          controller: _controller,
          toolbarIconSize: 24,
          showFontFamily: false,
          showFontSize: false,
          showCodeBlock: false,
          showListCheck: false,
          // showIndent: false,
          showQuote: false,
          showLink: false,
          showSearchButton: false,
          showUndo: false,
          showRedo: false,
          showSubscript: false,
          showSuperscript: false,
          showClearFormat: false,
          showHeaderStyle: false,
          // showColorButton: false,
          showBackgroundColorButton: false,
          showStrikeThrough: false,
          showAlignmentButtons: true,
          showInlineCode: false,
        ),
      ),
    );
  }
}
