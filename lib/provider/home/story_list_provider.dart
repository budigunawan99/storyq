import 'package:flutter/widgets.dart';
import 'package:storyq/data/api/api_services.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/static/story_list_result_state.dart';

class StoryListProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final AuthRepository _authRepository;

  StoryListProvider(this._apiServices, this._authRepository);

  StoryListResultState _resultState = StoryListNoneState();

  StoryListResultState get resultState => _resultState;

  Future<void> fetchStoryList() async {
    try {
      _resultState = StoryListLoadingState();
      notifyListeners();

      final session = await _authRepository.getSession();

      if (session == null || session.token == null) {
        _resultState = StoryListErrorState("Session tidak ditemukan.");
        notifyListeners();
        return;
      }

      final result = await _apiServices.getStoryList(session.token!);

      if (result.error) {
        _resultState = StoryListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = StoryListLoadedState(result.listStory);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryListErrorState(e.toString());
      notifyListeners();
    }
  }
}
