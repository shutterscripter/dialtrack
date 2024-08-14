import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class CSVController extends GetxController {
  RxList<List<dynamic>> data = <List<dynamic>>[].obs;
  RxString? filePath;
  RxBool flag = false.obs;

  /// `_pickFile` is a method that allows the user to select a CSV file.
  /// It uses the `file_picker` package to open a file picker dialog.
  /// The selected file is then read and its content is stored in the `data` list.
  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    // print(result.files.first.name);
    filePath = result.files.first.path!.obs;

    final input = File(filePath!.value).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    // print(fields);

    flag.value = true;
    data = fields.obs;
    print('data: $data');
    print('data length: ${data.length}');
  }


  /// `_pickFileForAddMoreContacts` is a method that allows the user to select a CSV file.
  void pickFileForAddMoreContacts() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    // print(result.files.first.name);
    filePath = result.files.first.path!.obs;

    final input = File(filePath!.value).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    // print(fields);

    flag.value = true;
    data.addAll(fields);
    print('data: $data');
    print('data length: ${data.length}');
  }

  /// `getExternalDocumentPath` is a method that returns the path to the Downloads folder.
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  /// `downloadFileToDownloadsFolder` is a method that downloads a file to the Downloads folder.
  Future<void> downloadFileToDownloadsFolder(context) async {
    // Load the asset file
    String assetPath = 'assets/files/test.csv';
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();

    // Create a Stream<List<int>> from the bytes
    final stream = Stream<List<int>>.fromIterable([bytes]);

    // Flatten the Stream<List<int>> to a Stream<int>
    final flattenedStream = stream.expand((byteList) => byteList);

    // Get the path to the Downloads folder
    final downloadsFolderPath = await getExternalDocumentPath();

    // Create a new file in the Downloads folder
    final file = File('$downloadsFolderPath/test.csv');

    // Write the bytes to the new file
    await file.writeAsBytes(bytes);

    print('File downloaded to: ${file.path}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'File downloaded to: ${file.path}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
