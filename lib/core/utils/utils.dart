import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Utilities {
  static showAlert(BuildContext snackBarcontext, String message) {
    return ScaffoldMessenger.of(snackBarcontext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  static Future<FilePickerResult?> pickFile() async {
    final picker = await FilePicker.platform.pickFiles(type: FileType.image);
    return picker;
  }
}
