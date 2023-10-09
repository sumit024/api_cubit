import 'package:nmg_assignment/cubit/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/post_repository.dart';

class PostsCubit extends Cubit<PostState> {
  final PostRepository postRepository;

  PostsCubit(this.postRepository) : super(const PostState());

  Future<void> getPosts() async {
    emit(state.copyWith(postStatus: PostStatus.loading));
    try {
      final postList = await postRepository.getPosts();
      emit(state.copyWith(
          postStatus: PostStatus.fetchPostsSuccess, postsList: postList));
    } catch (e) {
      emit(state.copyWith(
          postStatus: PostStatus.error, exception: e.toString()));
    }
  }

  Future<void> getUsers() async {
    emit(state.copyWith(postStatus: PostStatus.loading));
    try {
      final usersList = await postRepository.getUsersList();
      emit(state.copyWith(
          postStatus: PostStatus.fetchUsersListSuccess, usersList: usersList));
    } catch (e) {
      emit(state.copyWith(
          postStatus: PostStatus.error, exception: e.toString()));
    }
  }

  Future<void> getCommentsOnAPost({required String postId}) async {
    emit(state.copyWith(postStatus: PostStatus.loading));
    try {
      final commentsList =
          await postRepository.getCommentsOfAPost(postId: postId);
      emit(state.copyWith(
          postStatus: PostStatus.fetchCommentsSuccess,
          commentsList: commentsList));
    } catch (e) {
      emit(state.copyWith(
          postStatus: PostStatus.error, exception: e.toString()));
    }
  }
}
