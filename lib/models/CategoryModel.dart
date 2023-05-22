class CategoryModel {
  final String name;
  final String image;

  CategoryModel({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  CategoryModel.fromMap(Map<String, dynamic> categoryMap)
      : name = categoryMap["name"],
        image = categoryMap["image"];
}
