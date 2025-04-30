import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:storyq/data/api/api_services.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/static/create_story_result_state.dart';

class CreateStoryProvider extends ChangeNotifier {
  String? imagePath;
  XFile? imageFile;

  final ApiServices _apiServices;
  final AuthRepository _authRepository;

  CreateStoryProvider(this._apiServices, this._authRepository);

  CreateStoryResultState _resultState = CreateStoryNoneState();

  CreateStoryResultState get resultState => _resultState;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<void> uploadStory(
    List<int> bytes,
    String filename,
    String description,
  ) async {
    try {
      _resultState = CreateStoryLoadingState();
      notifyListeners();

      final session = await _authRepository.getSession();

      if (session == null || session.token == null) {
        _resultState = CreateStoryErrorState("Session tidak ditemukan.");
        notifyListeners();
        return;
      }

      final result = await _apiServices.uploadStory(
        session.token!,
        bytes,
        filename,
        description,
      );

      if (result.error) {
        _resultState = CreateStoryErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = CreateStoryLoadedState(result.message);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = CreateStoryErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(image, quality: compressQuality);
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }
}
