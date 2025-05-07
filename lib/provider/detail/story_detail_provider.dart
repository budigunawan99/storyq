import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:storyq/data/api/api_services.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/static/story_detail_result_state.dart';

class StoryDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final AuthRepository _authRepository;

  StoryDetailProvider(this._apiServices, this._authRepository);

  StoryDetailResultState _resultState = StoryDetailNoneState();

  StoryDetailResultState get resultState => _resultState;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  void setMarkers(String markerId, LatLng position) {
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      onTap: () {
        if (_mapController != null) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(position, 18),
          );
        }
      },
    );
    _markers.add(marker);
  }

  String? _address;
  String? get address => _address;

  Future<void> fetchStoryDetail(String id) async {
    try {
      _resultState = StoryDetailLoadingState();
      notifyListeners();

      final session = await _authRepository.getSession();

      if (session == null || session.token == null) {
        _resultState = StoryDetailErrorState("Session tidak ditemukan.");
        notifyListeners();
        return;
      }

      final result = await _apiServices.getStoryDetail(session.token!, id);

      if (result.error) {
        _resultState = StoryDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = StoryDetailLoadedState(result.story);

        if (result.story.lat != null && result.story.lon != null) {
          final latlng = LatLng(result.story.lat!, result.story.lon!);
          setMarkers(result.story.id, latlng);
          final info = await geo.placemarkFromCoordinates(
            latlng.latitude,
            latlng.longitude,
          );
          final place = info[0];
          _address =
              '${place.street}, ${place.administrativeArea}, ${place.country}';
        }

        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
