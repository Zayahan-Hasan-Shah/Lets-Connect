import 'dart:convert';
import 'dart:developer';

import 'package:frontend/src/core/api_urls.dart';
import 'package:frontend/src/models/posts_model/get_all_post_model.dart';
import 'package:frontend/src/services/common_services/api_service.dart';

class PostService {
  Future<Map<String, dynamic>> getAllPost(int page, int limit) async {
    try {
      final url = "${APIUrls.getAllPostUrl}?page=$page&limit=$limit";
      final response = await APIService.get(api: url);
      final decoded = json.decode(response.body);

      // posts is directly a list, not nested
      final posts = (decoded["posts"] as List)
          .map((json) => GetAllPostModel.fromJson(json))
          .toList();

      return {
        "posts": posts,
        "total": decoded["total"],
        "page": decoded["page"],
        "limit": decoded["limit"],
      };
    } catch (e) {
      log("Error in getting all post : $e");
    }
    return {};
  }
}
