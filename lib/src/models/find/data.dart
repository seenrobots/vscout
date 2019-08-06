import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../../utils/utils.dart';
import '../model.dart';

class FindDataModel extends Model {
  findStringData(String dataEntry) async {
    Map properties = parseArgsJson(dataEntry);
    await this.findMapData(properties);
    this.result['query'] = dataEntry;
    this.result['queryType'] = 'FIND/DATA/STRING';
    return this.result;
  }

  findMapData(Map dataEntry) async {
    this.result = await await this.databaseHandler.getMatches(dataEntry);
    this.result['query'] = dataEntry.toString();
    this.result['queryType'] = 'FIND/DATA/MAP';
    return this.result;
  }

  findFileData(String relativeFilePath) async {
    String fileFolder = '/../files/';
    //  Tries to find file in [files] folder.
    var absFilePath =
        ("${dirname(Platform.script.toFilePath()).toString()}$fileFolder$relativeFilePath");
    final inputFile = new File(absFilePath);
    String fileContents;
    fileContents = await inputFile.readAsString();
    //  Decode file contents as JSON.
    Map baseMap = json.decode(fileContents);
    // Remove trailing white space, convert inputs to string to allow for staticly typed Dart methods.
    Map properties = Map<String, String>();
    baseMap.forEach((k, v) =>
        properties[k is String ? k.trim() : k.toString().trim()] =
            v is String ? v.trim() : v.toString().trim());
    await this.findMapData(properties);
    this.result['query'] = relativeFilePath;
    this.result['queryType'] = 'FIND/DATA/MAP';
    return this.result;
  }
}
