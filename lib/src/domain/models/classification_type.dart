sealed class ClassificationType {
  final String name;

  const ClassificationType({required this.name});

  @override
  bool operator ==(covariant ClassificationType other) {
    return name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name;
}

class AllType extends ClassificationType {
  const AllType(int count) : super(name: '전체보기 ($count)');
}

class CategoryType extends ClassificationType {
  final int id;
  final String category;
  final int count;

  const CategoryType({
    required this.id,
    required this.category,
    required this.count,
  }) : super(name: '$category ($count)');
}

class TagType extends ClassificationType {
  final int id;
  final String tag;
  final int count;

  const TagType({
    required this.id,
    required this.tag,
    required this.count,
  }) : super(name: '$tag ($count)');
}
