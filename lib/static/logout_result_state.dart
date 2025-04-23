sealed class LogoutResultState {}

class LogoutNoneState extends LogoutResultState {}

class LogoutLoadingState extends LogoutResultState {}

class LogoutErrorState extends LogoutResultState {
  final String error;

  LogoutErrorState(this.error);
}

class LogoutLoadedState extends LogoutResultState {
  final String success;

  LogoutLoadedState(this.success);
}