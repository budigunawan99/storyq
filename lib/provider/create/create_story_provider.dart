import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
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

  String? _myAddress;
  String? get myAddress => _myAddress;

  LatLng? _myLatLng;
  LatLng? get myLatLng => _myLatLng;

  Future<geo.Placemark> getAddressByLatLng(LatLng latLng) async {
    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );
    return info[0];
  }

  Future<void> getMyLocation() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _myAddress = "Layanan lokasi tidak tersedia.";
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _myAddress = "Izin lokasi ditolak.";
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    final place = await getAddressByLatLng(latLng);
    _myLatLng = latLng;
    _myAddress =
        '${place.street}, ${place.administrativeArea}, ${place.country}';
    notifyListeners();
  }

  Future<void> uploadStory(
    List<int> bytes,
    String filename,
    String description,
    LatLng? latLng,
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
        latLng,
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
