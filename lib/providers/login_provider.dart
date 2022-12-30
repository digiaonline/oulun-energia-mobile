import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/core/network_api/authentication_api.dart';
import 'package:oulun_energia_mobile/flavors.dart';

final loginProvider = StateNotifierProvider<UserAuthNotifier, UserAuthState>(
    (ref) => UserAuthNotifier(
        UserAuthState(loading: false, loggedIn: LoggedInStatus.loggedOut)));

class UserAuthNotifier extends StateNotifier<UserAuthState> {
  UserAuthNotifier(super.state);

  void login(String user, String password) {
    state = state.copyWith(loading: true);
    var auth = Authentication();
    var api = AuthenticationApi(auth, F.baseUrl);
    api.requestToken().then((token) {
      if (token != null) {
        auth
            .setAuthenticationToken(token)
            .then((value) => api.login(username: user, password: password))
            .then((userAuth) => state = state.copyWith(
                loading: false,
                loggedIn: userAuth != null
                    ? LoggedInStatus.loggedIn
                    : LoggedInStatus.failed,
                userAuth: userAuth));
      } else {
        state = state.copyWith(
          loading: false,
          loggedIn: LoggedInStatus.failed,
        );
      }
    });
  }
}

class UserAuthState {
  final bool loading;
  final LoggedInStatus loggedIn;
  final UserAuth? userAuth;

  UserAuthState({required this.loading, required this.loggedIn, this.userAuth});

  UserAuthState copyWith(
      {bool? loading, LoggedInStatus? loggedIn, UserAuth? userAuth}) {
    return UserAuthState(
        loading: loading ?? this.loading,
        loggedIn: loggedIn ?? this.loggedIn,
        userAuth: userAuth ?? this.userAuth);
  }
}
