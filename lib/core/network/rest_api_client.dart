// We have to create an abstruct class for this rest_client

import 'package:clean_architecture_posts_project/core/network/http_client.dart';
import 'package:clean_architecture_posts_project/features/posts/data/models/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'rest_api_client.g.dart';

@RestApi(baseUrl: 'https://6798a390be2191d708b05542.mockapi.io/')
abstract class RestApiClient {
  factory RestApiClient(Dio dio, {String? baseUrl}) = _RestApiClient;

  @GET('posts')
  Future<List<Post>> getPosts();

  @DELETE('posts/{id}')
  Future<void> deletePost(@Path('id') String id);

  @POST('posts')
  Future<void> addPost(@Body() Post post);

  @PUT('posts/{id}')
  Future<Post> updatePost(@Path('id') String id, @Body() Post post);
}

// Provider for RestApiClient
final restapiClientProvider = Provider<RestApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return RestApiClient(dio);
});
