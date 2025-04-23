sealed class RegisterResultState {}

class RegisterNoneState extends RegisterResultState {}

class RegisterLoadingState extends RegisterResultState {}

class RegisterErrorState extends RegisterResultState {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterLoadedState extends RegisterResultState {
  final String success;

  RegisterLoadedState(this.success);
}
