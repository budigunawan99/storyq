import 'package:flutter/widgets.dart';
import 'package:storyq/data/api/api_services.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/static/story_detail_result_state.dart';

class StoryDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final AuthRepository _authRepository;

  StoryDetailProvider(this._apiServices, this._authRepository);

  StoryDetailResultState _resultState = StoryDetailNoneState();

  StoryDetailResultState get resultState => _resultState;

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
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
