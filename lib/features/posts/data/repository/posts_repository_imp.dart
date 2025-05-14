import 'package:clean_architecture_posts_project/features/posts/data/datasources/posts_data_source.dart';
import 'package:clean_architecture_posts_project/features/posts/data/models/post.dart';
import 'package:clean_architecture_posts_project/features/posts/domain/repository/posts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsRepositoryImp implements PostsRepository {
  PostsRepositoryImp(this.postsDataSource);

  // Here we want a datasource so we'll create a datasource of postdata
  // we also create the objects of datasource here in that way too

  final UserPostsDataSource postsDataSource;

  @override
  Future<List<Post>> getPosts() async {
    return await postsDataSource.getPosts();
  }

  @override
  Future<void> deletePost(id) async {
    return await postsDataSource.deletePost(id);
  }

  @override
  Future<void> addPost(post) async {
    return await postsDataSource.addPost(post);
  }

  @override
  Future<Post> updatePost(id, post) async {
    return await postsDataSource.updatePost(id, post);
  }
}

// now we have to create the repo provider from where we will inject the
// the data source
final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  final postsDataSourceRef = ref.watch(postDataSourceProvider);
  return PostsRepositoryImp(postsDataSourceRef);
});
