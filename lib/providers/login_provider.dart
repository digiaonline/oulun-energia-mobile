import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/core/network_api/authentication_api.dart';
import 'package:oulun_energia_mobile/flavors.dart';

final loginProvider = StateNotifierProvider<UserAuthNotifier, UserAuthState>(
    (ref) => UserAuthNotifier(UserAuthState(
        loading: false,
        loggedInStatus: LoggedInStatus.notInitialized,
        termsAccepted: false,
        rememberSignIn: false)));

class UserAuthNotifier extends StateNotifier<UserAuthState> {
  late final Authentication auth;
  late final AuthenticationApi api;

  UserAuthNotifier(super.state) {
    auth = Authentication();
    api = AuthenticationApi(auth, F.baseUrl);
    _initialize();
  }

  Future<void> login(String user, String password, bool rememberSignIn) async {
    state = state.copyWith(loading: true);
    var token = await api.requestToken().catchError(_onTokenError);
    if (token != null) {
      try {
        await auth.setAuthenticationToken(token);
        var userAuth = await api.login(username: user, password: password);
        await _setSignInParams(userAuth, rememberSignIn);
        state = state.copyWith(
            loading: false,
            rememberSignIn: rememberSignIn,
            loggedIn: userAuth != null
                ? LoggedInStatus.loggedIn
                : LoggedInStatus.failed,
            userAuth: userAuth);
      } catch (error) {
        _onLoginError(error);
      }
    } else {
      state = state.copyWith(
        loading: false,
        loggedIn: LoggedInStatus.failed,
      );
    }
  }

  void logout() async {
    state = state.copyWith(loading: true);
    // todo clear all user sensitive data here
    await auth.setAuthenticationToken("");
    await auth.setUserAuth("");
    state = UserAuthState(
        loading: false,
        loggedInStatus: LoggedInStatus.loggedOut,
        termsAccepted: false,
        rememberSignIn: false);
  }

  void acceptTerms(bool accept) {
    state = state.copyWith(termsAccepted: accept);
  }

  void rememberSignIn(bool remember) {
    state = state.copyWith(rememberSignIn: remember);
  }

  Future<bool> tryReLogin() async {
    var userString = await auth.getUserAuth();
    if (userString == null || userString.isEmpty) {
      _onLoginError(AuthenticationError
          .unauthorized); // todo think if we need some UI change
      return false;
    }
    var userAuth = UserAuth.fromJson(jsonDecode(userString));
    if (userAuth.username == null || userAuth.password == null) {
      _onLoginError(AuthenticationError.unauthorized);
      return false;
    }

    await login(userAuth.username!, userAuth.password!, true);
    return state.loggedInStatus == LoggedInStatus.loggedIn;
  }

  void _initialize() {
    state = state.copyWith(loading: true);
    auth.getAuthenticationToken().then((token) {
      var tokenNotEmpty = token?.isNotEmpty ?? false;
      tokenNotEmpty
          ? auth
              .getUserAuth()
              .then((userAuth) => userAuth != null
                  ? _setLoggedIn(UserAuth.fromJson(jsonDecode(userAuth)))
                  : _setLoggedOut())
              .onError((_, stackTrace) => _setLoggedOut())
              .catchError((_) => _setLoggedOut())
          : state = state.copyWith(
              loading: false,
              loggedIn: token != null
                  ? LoggedInStatus.visitor
                  : LoggedInStatus.notInitialized);
    });
  }

  Future<void> _setSignInParams(UserAuth? userAuth, bool rememberSignIn) {
    return rememberSignIn
        ? auth.setUserAuth(jsonEncode(userAuth?.toJsonMap()))
        : Future.value();
  }

  void _setLoggedOut() {
    state = state.copyWith(loading: false, loggedIn: LoggedInStatus.loggedOut);
  }

  void _setLoggedIn(UserAuth userAuth) {
    state = state.copyWith(
        userAuth: userAuth,
        loading: false,
        loggedIn: LoggedInStatus.loggedIn,
        termsAccepted: true);
  }

  _onLoginError(Object error) {
    state = state.copyWith(loading: false, loggedIn: LoggedInStatus.failed);
    return Future.value(state);
  }

  _onTokenError(Object error) {
    state = state.copyWith(loading: false, loggedIn: LoggedInStatus.failed);
    return Future.value(null);
  }
}

class UserAuthState {
  final bool loading;
  final LoggedInStatus loggedInStatus;
  final UserAuth? userAuth;
  final bool termsAccepted;
  final bool rememberSignIn;

  UserAuthState(
      {required this.loading,
      required this.loggedInStatus,
      required this.termsAccepted,
      required this.rememberSignIn,
      this.userAuth});

  UserAuthState copyWith(
      {bool? loading,
      LoggedInStatus? loggedIn,
      UserAuth? userAuth,
      bool? termsAccepted,
      bool? rememberSignIn}) {
    return UserAuthState(
        loading: loading ?? this.loading,
        loggedInStatus: loggedIn ?? loggedInStatus,
        userAuth: userAuth ?? this.userAuth,
        termsAccepted: termsAccepted ?? this.termsAccepted,
        rememberSignIn: rememberSignIn ?? this.rememberSignIn);
  }

  bool loggedIn() {
    return loggedInStatus == LoggedInStatus.loggedIn;
  }
}
