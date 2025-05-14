import 'package:clean_architecture_posts_project/core/network/rest_api_client.dart';
import 'package:clean_architecture_posts_project/features/posts/data/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class UserPostsDataSource {
  Future<List<Post>> getPosts();
  Future<void> deletePost(String id);
  Future<void> addPost(Post post);
  Future<Post> updatePost(String id, Post post);

}

class PostsDataSource implements UserPostsDataSource {
  PostsDataSource({required this.apiClient});

  final RestApiClient apiClient;

  @override
  Future<List<Post>> getPosts() async {
    return await apiClient.getPosts();
  }

  @override
  Future<void> deletePost(id) async {
    return await apiClient.deletePost(id);
  }

  @override
  Future<void> addPost(post) async {
    return await apiClient.addPost(post);
  }

  @override
  Future<Post> updatePost(String id, Post post) async {
    return await apiClient.updatePost(id, post);
  }
}

// To make the datasource expose or available through out the app we will
// create its provider
final postDataSourceProvider = Provider<UserPostsDataSource>((ref) {
  final restClient = ref.watch(restapiClientProvider);
  return PostsDataSource(apiClient: restClient);
});
