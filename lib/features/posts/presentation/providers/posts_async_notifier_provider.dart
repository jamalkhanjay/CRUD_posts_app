import 'package:clean_architecture_posts_project/features/posts/data/models/post.dart';
import 'package:clean_architecture_posts_project/features/posts/data/repository/posts_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsAsynNotifier extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() async {
    final repo = ref.watch(postsRepositoryProvider);
    return await repo.getPosts();
  }

  // Delete a post
  Future<void> deletePost(String id) async {
    final repo = ref.watch(postsRepositoryProvider);
    try {
      await repo.deletePost(id);
      if (state.value == null) return;
      state = AsyncValue.data(
        state.value!.where((post) => post.id != id).toList(),
      );
    } catch (e) {
      debugPrint('Error deleting post: ${e.toString()}');
      throw Exception('Failed to delete post');
    }
  }

  // Creating a new post
  Future<void> addPost(Post newPost) async {
    final repo = ref.watch(postsRepositoryProvider);
    try {
      await repo.addPost(newPost);
      final currentState = state.value ?? [];
      state = AsyncValue.data([...currentState, newPost]);
    } catch (e) {
      debugPrint('Error adding post: ${e.toString()}');
      throw Exception('Failed to add post');
    }
  }

  // Updating a post
  Future<Post> updatePost(String id, Post updatedPost) async {
    final repo = ref.watch(postsRepositoryProvider);

    try {
      final updatePostFromApi = await repo.updatePost(id, updatedPost);

      if (state.value == null) return updatePostFromApi;

      // First we've to replace the old post with the updated post
      final changedPosts = state.value!
          .map((post) => post.id == id ? updatePostFromApi : post)
          .toList();

      state = AsyncValue.data(changedPosts);

      return updatePostFromApi;
    } catch (e) {
      debugPrint('Error updating post: ${e.toString()}');
      throw Exception('Failed to update post');
    }
  }
}

final postAsyncNotifierProvider =
    AsyncNotifierProvider<PostsAsynNotifier, List<Post>>(
  () => PostsAsynNotifier(),
);
