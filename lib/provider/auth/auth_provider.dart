import 'package:flutter/widgets.dart';
import 'package:storyq/data/api/api_services.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/data/model/session.dart';
import 'package:storyq/data/model/user.dart';
import 'package:storyq/static/login_result_state.dart';
import 'package:storyq/static/logout_result_state.dart';
import 'package:storyq/static/register_result_state.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiServices _apiServices;

  AuthProvider(this.authRepository, this._apiServices);

  LoginResultState _loginResultState = LoginNoneState();

  LoginResultState get loginResultState => _loginResultState;

  RegisterResultState _registerResultState = RegisterNoneState();

  RegisterResultState get registerResultState => _registerResultState;

  LogoutResultState _logoutResultState = LogoutNoneState();

  LogoutResultState get logoutResultState => _logoutResultState;

  bool isLoggedIn = false;

  Session? _session;
  Session? get session => _session;

  Future<bool> login(User user) async {
    try {
      _loginResultState = LoginLoadingState();
      notifyListeners();

      final result = await _apiServices.login(user);
      if (result.error) {
        _loginResultState = LoginErrorState(result.message);
        notifyListeners();
        return false;
      }

      await authRepository.login(result.loginResult);
      isLoggedIn = await authRepository.isLoggedIn();
      _session = await authRepository.getSession();

      _loginResultState = LoginLoadedState(result.loginResult);
      notifyListeners();
    } on Exception catch (e) {
      _loginResultState = LoginErrorState(e.toString());
      notifyListeners();
    }

    return isLoggedIn;
  }

  Future<bool> register(User user) async {
    try {
      _registerResultState = RegisterLoadingState();
      notifyListeners();

      final result = await _apiServices.register(user);
      if (result.error) {
        _registerResultState = RegisterErrorState(result.message);
        notifyListeners();
        return false;
      }

      _registerResultState = RegisterLoadedState(result.message);
      notifyListeners();
    } on Exception catch (e) {
      _registerResultState = RegisterErrorState(e.toString());
      notifyListeners();
    }

    return true;
  }

  Future<void> logout() async {
    try {
      _logoutResultState = LogoutLoadingState();
      notifyListeners();

      await authRepository.logout();
      isLoggedIn = await authRepository.isLoggedIn();

      _logoutResultState = LogoutLoadedState("Logout berhasil");
      notifyListeners();
    } on Exception catch (e) {
      _logoutResultState = LogoutErrorState(e.toString());
      notifyListeners();
    }
  }
}
