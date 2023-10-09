import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nmg_assignment/cubit/post_state.dart';
import 'package:nmg_assignment/cubit/posts_cubit.dart';
import 'package:nmg_assignment/data/models/posts_response.dart';
import 'package:nmg_assignment/view/comments_screen.dart';

import '../data/models/users_list_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UsersListResponse> usersList = [];
  List<PostsResponse> postsList = [];

  @override
  void initState() {
    BlocProvider.of<PostsCubit>(context).getUsers();
    BlocProvider.of<PostsCubit>(context).getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Posts with Author Name'),
      ),
      body: BlocConsumer<PostsCubit, PostState>(
        listener: (context, state) {
          if (state.postStatus == PostStatus.fetchUsersListSuccess) {
            usersList = state.usersList ?? [];
          }
          if (state.postStatus == PostStatus.fetchPostsSuccess) {
            postsList = state.postsList ?? [];
          }

        },
        builder: (context, state) {
          if (state.postStatus == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              String author = usersList
                      .where((element) => element.id == postsList[index].userId)
                      .first
                      .name ??
                  '';
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                              postId: postsList[index].id.toString())));
                },
                child: getPostItem(
                    title: postsList[index].title ?? '',
                    body: postsList[index].body ?? '',
                    author: author),
              );
            },
            itemCount: postsList.length,
          );
        },
      ),
    );
  }

  Widget getPostItem(
      {required String title, required String body, required String author}) {
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
              body,
              style:
                  const TextStyle(fontSize: 14, overflow: TextOverflow.visible),
            ),
            Text(
              'Author: $author',
              style:
                  const TextStyle(fontSize: 12, overflow: TextOverflow.visible),
            ),
          ],
        ),
      ),
    );
  }
}
