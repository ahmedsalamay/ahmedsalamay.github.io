import 'dart:io';
import 'dart:typed_data';
import 'package:fimto_frame/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ChooseFrameViewModel extends ChangeNotifier {
  final List<Uint8List> _pickedFiles = [];
  List<Uint8List> get pickedFiles => _pickedFiles;

  bool get isImagesPicked => _pickedFiles.isNotEmpty;

  bool isDeleteButtonVisible = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void showDeleteButton() {
    isDeleteButtonVisible = true;
    notifyListeners();
  }

  void hideDeleteButton() {
    isDeleteButtonVisible = false;
    notifyListeners();
  }

  Future<void> initAsync() async {}

  frames _selectedFrame = frames.classic;
  frames get selectedFrame => _selectedFrame;
  void selectFrameAction(frames frame) {
    _selectedFrame = frame;
    notifyListeners();
  }

  Future<void> uploadPhoto() async {
    // if (kIsWeb) {
    setLoadingState(true);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        onFileLoading: (status) {
          print('FilePickerStatus: $status');
          if (status == FilePickerStatus.done) {
            setLoadingState(false);
            print('FilePickerStatus: $status');
            // List<File> files =
            // result.paths.map((path) => File(path!)).toList();
            // // List<File> files = result.files.map((e) => File(e.path!)).toList();
            // Get.toNamed(chooseFrameRoute, arguments: files);
          }
        });
    if (result != null) {
      if (kIsWeb) {
        List<Uint8List> files = result.files.map((e) => e.bytes!).toList();
        // List<File> files = result.files.map((e) => File(e.path!)).toList();
        _pickedFiles.addAll(files);
        notifyListeners();
      } else {
        // List<Uint8List> files = result.files.map((e) => e.bytes!).toList();
        List<File> files = result.files.map((e) => File(e.path!)).toList();
        files
            .map((e) => e.readAsBytes().then((value) {
                  _pickedFiles.add(value);
                  notifyListeners();
                }))
            .toList();
        notifyListeners();
      }
    }
  }

  void removePhoto(int index) {
    _pickedFiles.removeAt(index);
    notifyListeners();
  }
}
