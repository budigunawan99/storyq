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

  String? _tempAddress;
  String? get tempAddress => _tempAddress;

  LatLng? _tempLatLng;
  LatLng? get tempLatLng => _tempLatLng;

  Future<void> setTempAddressAndLatLng(LatLng latLng) async {
    _tempLatLng = latLng;
    final place = await getAddressByLatLng(latLng);
    _tempAddress =
        '${place.street}, ${place.administrativeArea}, ${place.country}';
    notifyListeners();
  }

  void setMyLocation() {
    _myLatLng = _tempLatLng;
    _myAddress = _tempAddress;
  }

  Future<geo.Placemark> getAddressByLatLng(LatLng latLng) async {
    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );
    return info[0];
  }

  bool _isServiceEnabled = false;
  bool get isServiceEnabled => _isServiceEnabled;

  bool _isPermissionGranted = false;
  bool get isPermissionGranted => _isPermissionGranted;

  Future<void> getMyLocation() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _isServiceEnabled = serviceEnabled;
        _myAddress = null;
        notifyListeners();
        return;
      }
    }

    _isServiceEnabled = serviceEnabled;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _isPermissionGranted = false;
        _myAddress = null;
        notifyListeners();
        return;
      }
    }

    _isPermissionGranted = true;

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    final place = await getAddressByLatLng(latLng);
    _myLatLng = latLng;
    _myAddress =
        '${place.street}, ${place.administrativeArea}, ${place.country}';
    notifyListeners();
  }

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  void setMarkers(Marker marker) {
    _markers.clear();
    _markers.add(marker);
    notifyListeners();
  }

  void setResultState(CreateStoryResultState value) {
    _resultState = value;
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
