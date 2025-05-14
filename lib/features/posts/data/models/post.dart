import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

// Adding a jsonSerializable for code generation
@JsonSerializable()
class Post {
  final String userName;
  final String avatar;
  final String description;
  final String id;

  Post({
    required this.userName,
    required this.avatar,
    required this.description,
    required this.id,
  });

  // Creating a copyWith method
  Post copyWith({
    String? avatar,
    String? description,
    String? userName,
    String? id,
  }) =>
      Post(
        avatar: avatar ?? this.avatar,
        description: description ?? this.description,
        userName: userName ?? this.userName,
        id: id ?? this.id,
      );

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
