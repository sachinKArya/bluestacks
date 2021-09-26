class RecommendedModel {
  String name;
  String coverUrl;
  String gameName;

  RecommendedModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        coverUrl = json['cover_url'],
        gameName = json['game_name'];

  RecommendedModel({
    this.name,
    this.coverUrl,
    this.gameName,
  });
}
