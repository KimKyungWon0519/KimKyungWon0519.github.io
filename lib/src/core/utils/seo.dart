import 'dart:html';

void createMetaTag(String title, String description) {
  _setMetaTag('title', title);
  _setMetaTag('description', description);
}

void createLinkTag(String canonicalHref) {
  _setLinkTag('canonical', canonicalHref);
}

void createOpenGraph(String title, String description, String url) {
  _setOpenGraph('og:title', title);
  _setOpenGraph('og:description', description);
  _setOpenGraph('og:url', url);
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

void _setOpenGraph(String property, String content) {
  final openGraph = document.head!.querySelector('meta[property="$property"]');

  if (openGraph != null) {
    openGraph.setAttribute('content', content);
  } else {
    final newMetaTag = MetaElement()
      ..setAttribute('property', property)
      ..content = content;
    document.head!.append(newMetaTag);
  }
}

void _setLinkTag(String rel, String href) {
  final linkTag = document.head!.querySelector('link[rel="$rel"]');

  if (linkTag != null) {
    linkTag.setAttribute('href', href);
  } else {
    final newMetaTag = LinkElement()
      ..rel = rel
      ..href = href;
    document.head!.append(newMetaTag);
  }
}
