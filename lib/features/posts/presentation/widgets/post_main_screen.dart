import 'package:clean_architecture_posts_project/features/posts/data/models/post.dart';
import 'package:clean_architecture_posts_project/features/posts/presentation/providers/posts_async_notifier_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostMainScreen extends ConsumerWidget {
  const PostMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postValue = ref.watch(postAsyncNotifierProvider);

    // New post
    final newPost = Post(
      userName: 'Zaryab',
      avatar: 'zaryab.jpg',
      description: 'I am Zaryab. Student of BSCS.',
      id: '21',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('User Posts App'),
      ),
      body: postValue.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final post = data[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  // backgroundImage: NetworkImage(post.avatar),
                  backgroundColor: Colors.deepPurple,
                ),
                title: Text(post.userName),
                subtitle: Text(post.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        ref
                            .read(postAsyncNotifierProvider.notifier)
                            .updatePost(post.id, post);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(postAsyncNotifierProvider.notifier)
                            .deletePost(post.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(
          error.toString(),
        ),
        loading: () => CupertinoActivityIndicator(),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          ref.read(postAsyncNotifierProvider.notifier).addPost(newPost);
        },
        icon: Icon(Icons.add),
        color: Colors.black,
        // highlightColor: ,
      ),
    );
  }
}
