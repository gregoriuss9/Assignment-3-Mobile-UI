class NewsModel {
  String? author;
  String? title;
  String? description;
  String? image;
  String? published_time;
  String? content;

  NewsModel({
    this.author,
    this.title,
    this.description,
    this.image,
    this.published_time,
    this.content,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    image = json['urlToImage'];
    published_time = json['publishedAt'];
    content = json['content'];
  }
}
