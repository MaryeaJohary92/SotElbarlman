class BusinessDataModel{
  List<NewsModel> articles=[];
  BusinessDataModel.fromJson({required List<dynamic> json}){
    json.forEach((element)
    {
      articles.add(NewsModel.fromJson(element));
    });
  }
}


class NewsModel{
  String? author;
  String? title;
  String? description;
  String? content;
  String? publishedAt;
  String? url;
  NewsModel.fromJson(Map<String, dynamic> json){
    author=json['source_id'];
    title=json['title'];
    content=json['content'];
    description=json['description'];
    publishedAt=json['pubDate'];
    url=json['link'];
  }
}