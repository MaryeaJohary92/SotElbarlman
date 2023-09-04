class SportsDataModel{
  List<SportsNewsModel> articles=[];
  SportsDataModel.fromJson({required List<dynamic> json}){
    json.forEach((element)
    {
      articles.add(SportsNewsModel.fromJson(element));
    });
  }
}


class SportsNewsModel{
  String? author;
  String? title;
  String? description;
  String? content;
  String? publishedAt;
  String? url;
  SportsNewsModel.fromJson(Map<String, dynamic> json){
    author=json['source_id'];
    title=json['title'];
    content=json['content'];
    description=json['description'];
    publishedAt=json['pubDate'];
    url=json['link'];

  }
}