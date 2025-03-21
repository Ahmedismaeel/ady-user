import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// import 'package:CWCFlutter/model/user.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static FileManager? _instance;

  FileManager._internal() {
    _instance = this;
  }

  factory FileManager() => _instance ?? FileManager._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _file async {
    final path = await _directoryPath;
    return File('$path/cheetah.txt');
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/cheetah.json');
  }

  Future<File> get _imageFile async {
    final path = await _directoryPath;
    return File('$path/cheetah_image');
  }

  Future<String> readTextFile() async {
    String fileContent = 'Cheetah Coding';

    File file = await _file;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }

    return fileContent;
  }

  Future<String> writeTextFile() async {
    String text = DateFormat('h:mm:ss').format(DateTime.now());

    File file = await _file;
    await file.writeAsString(text);
    return text;
  }

  Future<Map<String, String>> readJsonFile() async {
    File file = await _jsonFile;
    "read".log();
    if (await file.exists()) {
      try {
        var data = await file.readAsString();
        return json.decode(data);
      } catch (e) {
        print(e);
      }
    }

    return {};
  }

  Future<Map<String, String>> writeJsonFile(Map<String, String> map) async {
    File file = await _jsonFile;
    try {
      await file.writeAsString(json.encode(map));
      return map;
    } catch (e) {
      return map;
    }
  }

  // Future<Uint8List> writeImageFile() async {
  //   Response response = await Client().get(
  //     Uri.parse(
  //         'https://i.pinimg.com/originals/f5/1d/08/f51d08be05919290355ac004cdd5c2d6.png'),
  //   );

  //   Uint8List bytes = response.bodyBytes;
  //   File file = await _imageFile;
  //   await file.writeAsBytes(bytes);

  //   print(file.path);
  //   print(bytes);

  //   return bytes;
  // }

  // Future<Uint8List?> readImageFile() async {
  //   File file = await _imageFile;
  //   Uint8List? byteList;

  //   if (await file.exists()) {
  //     try {
  //       byteList = await file.readAsBytes();
  //     } catch (e) {
  //       print(e);
  //     }
  //   }

  //   return byteList;
  // }

  // deleteImage() async {
  //   File file = await _imageFile;
  //   if (await file.exists()) {
  //     await file.delete();
  //   }
  // }
}
