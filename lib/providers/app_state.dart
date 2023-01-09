import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';

final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  var loginState = ref.read(loginProvider);
  var initialState = AppStates.notInitialized;
  switch (loginState.loggedInStatus) {
    case LoggedInStatus.loggedOut:
      initialState = AppStates.loginView;
      break;
    case LoggedInStatus.failed:
      initialState = AppStates.loginView;
      break;
    case LoggedInStatus.visitor:
    case LoggedInStatus.loggedIn:
      initialState = AppStates.mainView;
      break;
    case LoggedInStatus.notInitialized:
      initialState = AppStates.firstTimeView;
      break;
  }
  print("${loginState.loggedInStatus.name} ${initialState.name}");
  return AppStateNotifier(AppState(initialState));
});

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier(super.state);

  void initialize() {}

  /// This method is used when user skips ftu & login
  void toMainView() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = state.copyWith(state: AppStates.mainView);
    });
  }

  void toLoginView() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = state.copyWith(state: AppStates.loginView);
    });
  }

  void loggedIn() {
    toMainView();
  }
}

class AppState {
  final bool loading;
  final AppStates current;

  AppState(this.current, {this.loading = false});

  AppState copyWith({AppStates? state, bool? loading}) {
    return AppState(state ?? current, loading: loading ?? this.loading);
  }
}

enum AppStates {
  notInitialized,
  firstTimeView,
  loginView,
  mainView,
}
