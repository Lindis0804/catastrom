class Category {
  final int id;
  final String code;
  final String description;

  const Category({
    required this.id,
    required this.code,
    required this.description,
  });

  factory Category.fromDynamic(dynamic rawCategory) {
    return Category(
      id: rawCategory['id'] ?? 0,
      code: rawCategory['code'] ?? '',
      description: rawCategory['description'] ?? '',
    );
  }
}
