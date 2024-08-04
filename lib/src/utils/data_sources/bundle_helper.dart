import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kkw_blog/src/constants/resources.dart';

class BundleHelper {
  const BundleHelper();

  Future<Map<String, dynamic>> getAssetManifest() async {
    return readFile(assetManifest).then((value) => jsonDecode(value));
  }

  Future<String> readFile(String path) async {
    return rootBundle.loadString(path);
  }
}
