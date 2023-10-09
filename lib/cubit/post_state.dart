import 'package:equatable/equatable.dart';
import 'package:nmg_assignment/models/comments_response.dart';
import 'package:nmg_assignment/models/posts_response.dart';

import '../models/users_list_response.dart';

enum PostStatus {
  initial, loading, fetchUsersListSuccess, fetchPostsSuccess, fetchCommentsSuccess, error
}

class PostState extends Equatable {
  final List<UsersListResponse>? usersList;
  final List<PostsResponse>? postsList;
  final List<CommentsResponse>? commentsList;

  final PostStatus postStatus;
  final String? exception;

  const PostState(
      {this.postStatus = PostStatus.initial, this.usersList,this.postsList,this.commentsList, this.exception});

  @override
  List<Object?> get props => [usersList, postsList,commentsList, postStatus, exception];

  PostState copyWith(
      {PostStatus? postStatus,
      List<UsersListResponse>? usersList,
        List<PostsResponse>? postsList,
        List<CommentsResponse>? commentsList,
      String? exception}) {
    return PostState(
        postStatus: postStatus ?? this.postStatus,
        usersList: usersList ?? this.usersList,
        postsList: postsList??this.postsList,
        commentsList: commentsList??this.commentsList,
        exception: exception ?? this.exception);
  }
}
