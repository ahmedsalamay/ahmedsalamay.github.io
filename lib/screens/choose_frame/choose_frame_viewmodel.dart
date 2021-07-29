import 'dart:io';
import 'dart:typed_data';

import 'package:fimto_frame/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseFrameViewModel extends ChangeNotifier {
  final List<Uint8List> pickedFiles;

  ChooseFrameViewModel({required this.pickedFiles});

  Future<void> initAsync() async {}

  frames _selectedFrame = frames.classic;
  frames get selectedFrame => _selectedFrame;
  void selectFrameAction(frames frame) {
    _selectedFrame = frame;
    notifyListeners();
  }
}
