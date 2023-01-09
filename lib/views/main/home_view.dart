import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';

class HomeView extends ConsumerWidget {
  static const String routeName = "home_route";

  final List<Widget> mainControls;

  const HomeView({super.key, required this.mainControls});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textTheme = Theme.of(context).textTheme;
    var loginStatus = ref.watch(loginProvider);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tervetuloa!',
            style: textTheme.headline2?.copyWith(color: Colors.white),
          ),
          Container(
            margin: Sizes.marginViewBorder * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loginStatus.loggedIn()
                    ? const SizedBox.shrink()
                    : const Icon(Icons.lock_outline, size: 16),
                Expanded(
                  child: Text(
                    loginStatus.loggedIn()
                        ? 'Ei tiedotteita TBD'
                        : 'Lukkosymbolilla merkityt osiot näet kirjautumalla palveluun',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.center,
        children: mainControls,
      ),
    ]);
  }
}
