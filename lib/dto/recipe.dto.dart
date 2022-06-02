class RecipeDto {
  String? id;
  String? name;
  String? description;
  String? image;
  String? category;
  double? totalTime;
  double? cookTime;
  double? serving;
  int? level;
  int? like;
  dynamic creator;
  List<Map<String, dynamic>>? ingredients;
  List<Map<String, dynamic>>? steps;

  RecipeDto({
    this.id,
    this.name,
    this.description,
    this.category,
    this.cookTime,
    this.totalTime,
    this.serving,
    this.level,
    this.image,
    this.like,
    this.creator,
    this.ingredients,
    this.steps,
  });

  factory RecipeDto.fromJson(Map<String, dynamic> json) => RecipeDto(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      category: json["category"],
      totalTime: json["totalTime"].toDouble(),
      cookTime: json["cookTime"].toDouble(),
      serving: json["serving"].toDouble(),
      level: json["level"],
      like: json["like"],
      creator: json["creator"],
      ingredients: json["ingredients"],
      steps: json["steps"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image": image,
        "category": category,
        "totalTime": totalTime,
        "cookTime": cookTime,
        "serving": serving,
        "level": level,
        "like": like,
        "creator": creator,
        "ingredients": ingredients,
        "steps": steps,
      };
}
