class RecipeDto {
  String name;
  String? description;
  String imagePath;
  String category;
  double totalTime;
  double cookTime;
  double servings;
  int level;

  RecipeDto({
    required this.name,
    required this.imagePath,
    required this.category,
    required this.totalTime,
    required this.cookTime,
    required this.servings,
    required this.level,
    this.description,
  });

  factory RecipeDto.fromJson(Map<String, dynamic> json) => RecipeDto(
        name: json["name"],
        description: json["description"],
        imagePath: json["imagePath"],
        category: json["category"],
        totalTime: json["totalTime"].toDouble(),
        cookTime: json["cookTime"].toDouble(),
        servings: json["servings"].toDouble(),
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "imagePath": imagePath,
        "category": category,
        "totalTime": totalTime,
        "cookTime": cookTime,
        "servings": servings,
        "level": level,
      };
}
