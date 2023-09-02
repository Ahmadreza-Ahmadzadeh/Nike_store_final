class CommentEntity {
  final int id;
  final String title;
  final String email;
  final String date;
  final String content;

  CommentEntity(
    this.id,
    this.title,
    this.email,
    this.date,
    this.content,
  );

  CommentEntity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        email = json["author"]["email"],
        date = json["date"],
        content = json["content"];
}
