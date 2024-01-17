import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageHelper {
  static Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<File> getLocalFile(String fileName) async {
    final path = await _localPath;

    if (await File('$path/$fileName').exists()) return File('$path/$fileName');
    return File('$path/$fileName').create();
  }
}
