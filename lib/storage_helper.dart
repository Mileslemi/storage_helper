import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StorageHelper {
  static Future<String> get _localPath async {
    final dir = await getApplicationSupportDirectory();
    return dir.path;
  }

  Future<File> getLocalJsonFile(String fileName) async {
    final path = await _localPath;

    if (await File('$path/$fileName').exists()) return File('$path/$fileName');

    File f = await File('$path/$fileName').create();
    f.writeAsString(jsonEncode({}));
    return f;
  }

  Future<Map> readLocalJsonFile(String fileName) async {
    try {
      final file = await getLocalJsonFile(fileName);
      Map y = jsonDecode(await file.readAsString());
      return y;
    } catch (e) {
      debugPrint("$e");
      return {};
    }
  }

  Future<File> writeToLocalJsonFile(String fileName, Map dataToSave) async {
    final file = await getLocalJsonFile(fileName);

    file.writeAsString(json.encode(dataToSave));
    return file;
  }
}
