class BrandModel {
  late int count;
  late String next;
  late String previous;
  late List<Results> results;

  BrandModel(
      {required this.count,
      required this.next,
      required this.previous,
      required this.results});

  BrandModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  late String name;
  late String slug;
  late String imageUrl;

  Results({required this.name, required this.slug, required this.imageUrl});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    imageUrl = json['image_url'];
  }

  get fromSubProducts => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
