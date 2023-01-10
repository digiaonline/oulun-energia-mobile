import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/core/network_api/authentication_api.dart';
import 'package:oulun_energia_mobile/flavors.dart';

final loginProvider = StateNotifierProvider<UserAuthNotifier, UserAuthState>(
    (ref) => UserAuthNotifier(UserAuthState(
        loading: false, loggedInStatus: LoggedInStatus.notInitialized)));

class UserAuthNotifier extends StateNotifier<UserAuthState> {
  late final Authentication auth;
  late final AuthenticationApi api;

  UserAuthNotifier(super.state) {
    auth = Authentication();
    api = AuthenticationApi(auth, F.baseUrl);
    _initialize();
  }

  Future<void> login(String user, String password) async {
    state = state.copyWith(loading: true);
    var token = await api.requestToken();

    if (token != null) {
      await auth.setAuthenticationToken(token);
      UserAuth? userAuth = await api.login(username: user, password: password);

      if (userAuth != null) {
        state = state.copyWith(
            loading: false,
            loggedIn: userAuth != null
                ? LoggedInStatus.loggedIn
                : LoggedInStatus.failed,
            userAuth: userAuth);
      } else {
        state = state.copyWith(
          loading: false,
          loggedIn: LoggedInStatus.failed,
        );
      }
    }
  }

  void _initialize() {
    state = state.copyWith(loading: true);
    auth.getAuthenticationToken().then((token) {
      var tokenNotEmpty = token?.isNotEmpty ?? false;
      tokenNotEmpty
          ? state =
              state.copyWith(loading: false, loggedIn: LoggedInStatus.loggedOut)
          : state = state.copyWith(
              loading: false,
              loggedIn: token != null
                  ? LoggedInStatus.visitor
                  : LoggedInStatus.notInitialized);
    });
  }
}

class UserAuthState {
  final bool loading;
  final LoggedInStatus loggedInStatus;
  final UserAuth? userAuth;

  UserAuthState(
      {required this.loading, required this.loggedInStatus, this.userAuth});

  UserAuthState copyWith(
      {bool? loading, LoggedInStatus? loggedIn, UserAuth? userAuth}) {
    return UserAuthState(
        loading: loading ?? this.loading,
        loggedInStatus: loggedIn ?? loggedInStatus,
        userAuth: userAuth ?? this.userAuth);
  }

  bool loggedIn() {
    return loggedInStatus == LoggedInStatus.loggedIn;
  }
}
