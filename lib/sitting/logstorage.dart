
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LogStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/log.txt');
  }

  Future<String?> readLogFile() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
        //int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeLogFile(String log) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(log);
  }
}
