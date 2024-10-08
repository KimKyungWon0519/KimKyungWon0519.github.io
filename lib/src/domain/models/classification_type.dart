sealed class ClassificationType {
  final String name;
  final int count;

  const ClassificationType({
    required this.name,
    required this.count,
  });

  @override
  bool operator ==(covariant ClassificationType other) {
    return other.runtimeType == runtimeType &&
        (name == other.name && count == other.count);
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => '$name  ($count)';
}

class AllType extends ClassificationType {
  const AllType(int count)
      : super(
          name: '전체보기',
          count: count,
        );
}

class CategoryType extends ClassificationType {
  final int id;

  const CategoryType({
    required this.id,
    required super.name,
    required super.count,
  });
}

class TagType extends ClassificationType {
  final int id;

  const TagType({
    required this.id,
    required super.name,
    required super.count,
  });
}
