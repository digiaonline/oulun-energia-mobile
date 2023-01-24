import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_fault_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_map_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notice_popup_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_notices_view.dart';
import 'package:oulun_energia_mobile/views/interruptions/interruptions_selections_view.dart';
import 'package:oulun_energia_mobile/views/login/forgot_password_view.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/login/privacy_view.dart';
import 'package:oulun_energia_mobile/views/login/register_view.dart';
import 'package:oulun_energia_mobile/views/main/home_view.dart';
import 'package:oulun_energia_mobile/views/terms/service_terms.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'widget_ext.dart';

class Config {
  static bool isLoggedIn(WidgetRef ref) {
    LoggedInStatus loggedInStatus = ref.read(loginProvider).loggedInStatus;
    return loggedInStatus == LoggedInStatus.loggedIn;
  }

  static List<BottomNavigationBarItem> getUserItems(
      BuildContext context, WidgetRef ref, int currentIndex) {
    var locals = AppLocalizations.of(context)!;
    List<BottomNavigationBarItem Function(int, int)> items = [
      (currentIndex, index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: Sizes.mainViewIconSize,
              height: Sizes.mainViewIconSize,
              color: currentIndex == index
                  ? defaultTheme.bottomNavigationBarTheme.selectedItemColor
                  : defaultTheme.bottomNavigationBarTheme.unselectedItemColor,
            ).toBottomBarIcon(selected: currentIndex == index),
            label: locals.usageViewHome,
          ),
      (currentIndex, index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/monitoring.svg',
              width: Sizes.mainViewIconSize,
              height: Sizes.mainViewIconSize,
              color: currentIndex == index
                  ? defaultTheme.bottomNavigationBarTheme.selectedItemColor
                  : defaultTheme.bottomNavigationBarTheme.unselectedItemColor,
            ).toBottomBarIcon(selected: currentIndex == index),
            label: locals.usageViewMyUsage,
          ),
      (currentIndex, index) => BottomNavigationBarItem(
            icon: const Icon(
              Icons.fmd_bad_outlined,
              size: Sizes.mainViewIconSize,
            ).toBottomBarIcon(selected: currentIndex == index),
            label: locals.interruptionsViewTitle,
          ),
      (currentIndex, index) => BottomNavigationBarItem(
            icon: const Icon(
              Icons.support_agent_outlined,
              size: Sizes.mainViewIconSize,
            ).toBottomBarIcon(selected: currentIndex == index),
            label: locals.usageViewContact,
          ),
    ];
    if (!isLoggedIn(ref)) {
      items.removeAt(1);
    }
    return items
        .asMap()
        .entries
        .map((entries) => entries.value(currentIndex, entries.key))
        .toList();
  }

  static Map<String, Map<String, dynamic>> getUserRouteSettings(
      BuildContext context) {
    Map<String, Map<String, dynamic>> settings = {
      ForgotPasswordView.routeName: ForgotPasswordView.getSettings(context),
      HomeView.routeName: HomeView.getSettings(context),
      UsageInfoView.routeName: UsageInfoView.getSettings(context),
      UsageSettingsView.routeName: UsageSettingsView.getSettings(context),
      UsageSelectionsView.routeName: UsageSelectionsView.getSettings(),
      LoginView.routeName: LoginView.getSettings(),
      InterruptionsSelectionsView.routeName:
          InterruptionsSelectionsView.getSettings(),
      InterruptionsFaultView.routeName:
          InterruptionsFaultView.getSettings(context),
      InterruptionsNoticesView.routeName:
          InterruptionsNoticesView.getSettings(context),
      InterruptionNoticePopupView.routeName:
          InterruptionNoticePopupView.getSettings(context),
      InterruptionsMapView.routeName: InterruptionsMapView.getSettings(context),
      PrivacyView.routeName: PrivacyView.getSettings(context),
      RegisterView.routeName: RegisterView.getSettings(context),
      ContactUsView.routeName: ContactUsView.getSettings(),
      ServiceTermsView.routeName: ServiceTermsView.getSettings()
    };

    return settings;
  }

  static List<String> getUserRouteNames(BuildContext context, WidgetRef ref) {
    var routes = [
      HomeView.routeName,
      UsageSelectionsView.routeName,
      InterruptionsSelectionsView.routeName,
      ContactUsView.routeName
    ];
    if (!isLoggedIn(ref)) {
      routes.removeAt(1);
    }
    return routes;
  }
}
