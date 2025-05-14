import 'package:clean_architecture_posts_project/features/posts/data/models/post.dart';

abstract interface class PostsRepository {
  Future<List<Post>> getPosts();
  Future<void> deletePost(String id);
  Future<void> addPost(Post post);
  Future<Post> updatePost(String id, Post post);
}
