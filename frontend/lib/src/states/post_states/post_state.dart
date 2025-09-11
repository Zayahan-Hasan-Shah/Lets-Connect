import 'package:frontend/src/models/posts_model/get_all_post_model.dart';


class PostState {
  final List<GetAllPostModel> posts;
  final bool isLoading;
  final String? error;
  final int page;
  final bool hasMore;

  PostState({
    this.posts = const [],
    this.isLoading = false,
    this.error,
    this.page = 1,
    this.hasMore = true,
  });

  PostState copyWith({
    List<GetAllPostModel>? posts,
    bool? isLoading,
    String? error,
    int? page,
    bool? hasMore,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
