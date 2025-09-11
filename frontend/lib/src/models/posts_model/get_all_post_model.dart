
class GetAllPostModel {
  int id;
  int userId;
  String username;
  String content;
  String createdAt;
  String? updatedAt;
  String? mediaUrl;
  String? mediaType;

  GetAllPostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.mediaUrl,
    this.mediaType,
    required this.createdAt,
    this.updatedAt,
    required this.username,
  });

  factory GetAllPostModel.fromJson(Map<String, dynamic> json) =>
      GetAllPostModel(
        id: json['id'],
        userId: json['user_id'],
        content: json['content'],
        mediaUrl: json['media_url'],
        mediaType: json['media_type'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "media_url": mediaUrl,
        "media_type": mediaType,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "username": username,
      };
}
