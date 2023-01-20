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

  void login(String user, String password, bool rememberSignIn) {
    state = state.copyWith(loading: true);
    api.requestToken().then((token) {
      if (token != null) {
        auth
            .setAuthenticationToken(token)
            .then((value) => api.login(username: user, password: password))
            .then((userAuth) => _setSignInParams(userAuth, rememberSignIn).then(
                (value) => state = state.copyWith(
                    loading: false,
                    rememberSignIn: rememberSignIn,
                    loggedIn: userAuth != null
                        ? LoggedInStatus.loggedIn
                        : LoggedInStatus.failed,
                    userAuth: userAuth)))
            .catchError((_) {
          state =
              state.copyWith(loading: false, loggedIn: LoggedInStatus.failed);
          return Future.value(state);
        });
      } else {
        state = state.copyWith(
          loading: false,
          loggedIn: LoggedInStatus.failed,
        );
      }
    });
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

  Future<void> _setSignInParams(UserAuth? userAuth, bool rememberSignIn) {
    return rememberSignIn
        ? auth.setUserAuth(jsonEncode(userAuth?.toJsonMap()))
        : Future.value();
  }

  void acceptTerms(bool accept) {
    state = state.copyWith(termsAccepted: accept);
  }

  void rememberSignIn(bool remember) {
    state = state.copyWith(rememberSignIn: remember);
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
