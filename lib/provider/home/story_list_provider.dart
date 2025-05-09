import 'package:flutter/widgets.dart';
import 'package:storyq/data/api/api_services.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/data/model/story.dart';
import 'package:storyq/static/story_list_result_state.dart';

class StoryListProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final AuthRepository _authRepository;

  StoryListProvider(this._apiServices, this._authRepository);

  StoryListResultState _resultState = StoryListNoneState();

  StoryListResultState get resultState => _resultState;

  int? page = 1;

  void setPage(int value) {
    page = value;
    notifyListeners();
  }

  int size = 10;
  final List<Story> appendedStory = [];

  void removeAllStories() {
    appendedStory.clear();
    notifyListeners();
  }

  Future<void> fetchStoryList() async {
    try {
      if (page == 1) {
        _resultState = StoryListLoadingState();
        notifyListeners();
      }

      final session = await _authRepository.getSession();

      if (session == null || session.token == null) {
        _resultState = StoryListErrorState("Session tidak ditemukan.");
        notifyListeners();
        return;
      }

      final result = await _apiServices.getStoryList(
        session.token!,
        page!,
        size,
      );

      if (result.error) {
        _resultState = StoryListErrorState(result.message);
        notifyListeners();
      } else {
        appendedStory.addAll(result.listStory);
        _resultState = StoryListLoadedState(appendedStory);

        if (result.listStory.length < size) {
          page = null;
        } else {
          page = page! + 1;
        }
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryListErrorState(e.toString());
      notifyListeners();
    }
  }
}
