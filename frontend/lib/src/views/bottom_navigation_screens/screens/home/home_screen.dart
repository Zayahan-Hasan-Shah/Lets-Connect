import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/post_controller/get_all_post_controller.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/widgets/common_widgets/custom_appbar.dart';
import 'package:frontend/src/widgets/home_screen_widgets/home_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(postControllerProvider.notifier).fetchPosts());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(postControllerProvider.notifier).fetchPosts(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postControllerProvider);
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: ColorAssets.backgroundColor,
      appBar: const CustomAppbar(title: 'Home', isback: false),
      body: state.isLoading && state.posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(
                  child: Text(
                  "Error: ${state.error}",
                  style: TextStyle(color: Colors.white),
                ))
              : RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(postControllerProvider.notifier)
                        .fetchPosts();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasMore
                        ? state.posts.length + 1
                        : state.posts.length,
                    itemBuilder: (context, index) {
                      if (index < state.posts.length) {
                        final post = state.posts[index];
                        return HomeCard(
                          onTap: () {},
                          desc: post.content,
                          time: post.createdAt,
                          userName: post.username,
                          likes: 32,
                          likeTap: () {},
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                ),
    );
  }
}
