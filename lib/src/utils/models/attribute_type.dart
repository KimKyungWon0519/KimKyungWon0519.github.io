sealed class AttributeType {}

class AllAttri extends AttributeType {}

class CategoriesAttri extends AttributeType {
  final String name;

  CategoriesAttri(this.name);
}

class TagsAttri extends AttributeType {
  final String name;

  TagsAttri(this.name);
}
