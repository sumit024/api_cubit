import 'package:flutter/material.dart';
import 'package:nmg_assignment/models/comments_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/post_state.dart';
import '../cubit/posts_cubit.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;

  const CommentsScreen({required this.postId, Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  List<CommentsResponse> commentsList = [];

  @override
  void initState() {
    BlocProvider.of<PostsCubit>(context)
        .getCommentsOnAPost(postId: widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Comments'),
      ),
      body: BlocConsumer<PostsCubit, PostState>(
        listener: (context, state) {
          if (state.postStatus == PostStatus.fetchCommentsSuccess) {
            commentsList = state.commentsList ?? [];
          }
        },
        builder: (context, state) {
          if (state.postStatus == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return getCommentsItem(
                  title: commentsList[index].name ?? '',
                  body: commentsList[index].body ?? '',
                  email: commentsList[index].email ?? '');
            },
            itemCount: commentsList.length,
          );
        },
      ),
    );
  }

  Widget getCommentsItem(
      {required String title, required String email, required String body}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, overflow: TextOverflow.visible),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              email,
              style:
                  const TextStyle(fontSize: 14, overflow: TextOverflow.visible),
            ),
            Text(
              body,
              style:
                  const TextStyle(fontSize: 12, overflow: TextOverflow.visible),
            ),
          ],
        ),
      ),
    );
  }
}
