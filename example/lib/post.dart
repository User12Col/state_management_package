class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({
    this.userId = 0,
    this.id = 0,
    this.title = '',
    this.body = '',
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"] ?? 0,
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        body: json["body"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
