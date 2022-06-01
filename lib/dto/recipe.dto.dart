class RecipeDto {
  String? id;
  String? name;
  String? description;
  String? image;
  String? category;
  double? totalTime;
  double? cookTime;
  double? servings;
  int? level;
  int? like;
  dynamic creator;
  Map<String, dynamic>? ingredients;

  RecipeDto({
    this.id,
    this.name,
    this.description,
    this.category,
    this.cookTime,
    this.totalTime,
    this.servings,
    this.level,
    this.image,
    this.like,
    this.creator,
    this.ingredients,
  });

  factory RecipeDto.fromJson(Map<String, dynamic> json) => RecipeDto(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      category: json["category"],
      totalTime: json["totalTime"].toDouble(),
      cookTime: json["cookTime"].toDouble(),
      servings: json["servings"].toDouble(),
      level: json["level"],
      like: json["like"],
      creator: json["creator"],
      ingredients: json["ingredients"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image": image,
        "category": category,
        "totalTime": totalTime,
        "cookTime": cookTime,
        "servings": servings,
        "level": level,
        "like": like,
        "creator": creator,
        "ingredients": ingredients
      };
}
