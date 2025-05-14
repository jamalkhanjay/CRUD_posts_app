import 'package:clean_architecture_posts_project/features/posts/data/models/post.dart';
import 'package:clean_architecture_posts_project/features/posts/presentation/pages/add_edit_post_page.dart';
import 'package:clean_architecture_posts_project/features/posts/presentation/pages/posts_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const PostsPage(),
      routes: [
        GoRoute(
          path: 'add-post',
          name: 'add-post',
          builder: (context, state) => const AddEditPostPage(),
        ),
        GoRoute(
          path: 'edit-post/:id',
          name: 'edit-post',
          builder: (context, state) {
            final Post post = state.extra as Post;
            final String id = state.pathParameters['id'] ?? '';
            return AddEditPostPage(post: post, id: id);
          },
        ),
      ],
    ),
  ],
);
