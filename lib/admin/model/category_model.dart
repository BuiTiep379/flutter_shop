class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  CategoryModel.fromMap(Map<String, dynamic> categoryMap)
      : id = categoryMap["id"],
        name = categoryMap["name"],
        image = categoryMap["image"];
}
