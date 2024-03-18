import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_docs_clone/styles/app_colors.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<DocumentsCubit>().getUserDocuments(
    //       (context.read<AuthCubit>().state as AuthAuthenticated).user.token,
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // title: const Text('Home'),
              title: const HomeToolBar(),
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              floating: true,
            ),
            // Builder(
            //   builder: (context) {
            //     final docState = context.watch<DocumentsCubit>().state;
            //     switch (docState.runtimeType) {
            //       case DocumentsLoaded:
            //         return SliverList(
            //             delegate: SliverChildBuilderDelegate(
            //           (context, index) {
            //             final doc = docState.documents[index];
            //             return InkWell(
            //               onTap: () {
            //                 Routemaster.of(context).push(
            //                   'document/d/${doc.id}',
            //                   queryParameters: {'title': doc.title},
            //                 );
            //               },
            //               child: ListTile(
            //                 title: Text(doc.title),
            //               ),
            //             );
            //           },
            //           childCount:
            //               (docState as DocumentsLoaded).documents.length,
            //         ),);
            //       default:
            //         return const SliverToBoxAdapter(child: SizedBox.expand());
            //     }
            //   },
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text('Untitled Document ${index + 1}'),
                    leading: const Icon(CupertinoIcons.doc_plaintext),
                    // trailing: IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.more_vert),
                    // ),
                    onTap: () {},
                  );
                },
                childCount: 20,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryDark,
        foregroundColor: AppColor.white,
        onPressed: () {
          Routemaster.of(context).push('document/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeToolBar extends StatelessWidget {
  const HomeToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: AppColor.fieldColor,
      title: const Text('Search Docs'),
      leading: const Icon(Icons.menu),
      trailing: const CircleAvatar(
        radius: 17,
        backgroundColor: AppColor.primaryDark,
        foregroundColor: AppColor.white,
        child: Text('A'),
      ),
    );
  }
}
