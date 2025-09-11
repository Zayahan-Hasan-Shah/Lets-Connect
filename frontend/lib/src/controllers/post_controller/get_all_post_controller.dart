import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/models/posts_model/get_all_post_model.dart';
import 'package:frontend/src/services/post_services/posts_service.dart';
import 'package:frontend/src/states/post_states/post_state.dart';

class PostController extends StateNotifier<PostState> {
  final PostService _service;

  PostController(this._service) : super(PostState());

  Future<void> fetchPosts({bool loadMore = false}) async {
    if (state.isLoading || (!state.hasMore && loadMore)) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final page = loadMore ? state.page + 1 : 1;
      final result = await _service.getAllPost(page, 10);

      final newPosts = result["posts"] as List<GetAllPostModel>;
      final total = result["total"] as int;

      final updatedPosts = loadMore ? [...state.posts, ...newPosts] : newPosts;

      state = state.copyWith(
        posts: updatedPosts,
        page: page,
        hasMore: updatedPosts.length < total,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

// provider
final postServiceProvider = Provider<PostService>((ref) {
  return PostService();
});

final postControllerProvider =
    StateNotifierProvider<PostController, PostState>((ref) {
  final service = ref.watch(postServiceProvider);
  return PostController(service);
});
