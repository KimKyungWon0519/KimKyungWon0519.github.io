import 'dart:html';

void createMetaTag(String title, String description) {
  _setMetaTag('title', title);
  _setMetaTag('description', description);
}

void createLinkTag(String canonicalHref) {
  _setLinkTag('canonical', canonicalHref);
}

void _setMetaTag(String name, String content) {
  final metaTag = document.head!.querySelector('meta[name="$name"]');

  if (metaTag != null) {
    metaTag.setAttribute('content', content);
  } else {
    final newMetaTag = MetaElement()
      ..name = name
      ..content = content;
    document.head!.append(newMetaTag);
  }
}

void _setLinkTag(String relName, String href) {
  final linkTag = document.head!.querySelector('link[rel="$relName"]');

  if (linkTag != null) {
    linkTag.setAttribute('href', href);
  } else {
    final newMetaTag = LinkElement()
      ..rel = relName
      ..href = href;
    document.head!.append(newMetaTag);
  }
}
