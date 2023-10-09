import 'package:nmg_assignment/data/models/comments_response.dart';
import 'package:nmg_assignment/data/models/posts_response.dart';
import 'package:nmg_assignment/data/models/users_list_response.dart';
import 'package:nmg_assignment/data/dio/dio_instance.dart';
import 'package:dio/dio.dart';

class PostRepository{
  late Dio _dio;
  PostRepository(){
    _dio=DioInstance().dio;
  }
  
  Future<List<UsersListResponse>> getUsersList()async{
    try{
      final response = await _dio.get('users');
      if(response.statusCode==200){
        final json= response.data as List;
        return json.map((e) => UsersListResponse.fromJson(e)).toList();
      }else{
        throw response.statusMessage??'';
      }
    }on DioException catch(e){
      throw e.response?.statusMessage??'';
    }catch(e){
      throw e.toString();
    }
    
  }
  Future<List<PostsResponse>> getPosts()async{
    try{
      final response = await _dio.get('posts');
      if(response.statusCode==200){
        final json= response.data as List;
        return json.map((e) => PostsResponse.fromJson(e)).toList();
      }else{
        throw response.statusMessage??'';
      }
    }on DioException catch(e){
      throw e.response?.statusMessage??'';
    }catch(e){
      throw e.toString();
    }

  }
  Future<List<CommentsResponse>> getCommentsOfAPost({required String postId})async{
    try{
      final response = await _dio.get('posts/$postId/comments');
      if(response.statusCode==200){
        final json= response.data as List;
        return json.map((e) => CommentsResponse.fromJson(e)).toList();
      }else{
        throw response.statusMessage??'';
      }
    }on DioException catch(e){
      throw e.response?.statusMessage??'';
    }catch(e){
      throw e.toString();
    }

  }
}