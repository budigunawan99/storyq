sealed class CreateStoryResultState {}

class CreateStoryNoneState extends CreateStoryResultState {}

class CreateStoryLoadingState extends CreateStoryResultState {}

class CreateStoryErrorState extends CreateStoryResultState {
  final String error;

  CreateStoryErrorState(this.error);
}

class CreateStoryLoadedState extends CreateStoryResultState {
  final String success;

  CreateStoryLoadedState(this.success);
}
