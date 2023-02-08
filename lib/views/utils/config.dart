import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_send_message_view.dart';
import 'package:oulun_energia_mobile/views/contact/contact_us_view.dart';
import 'package:oulun_energia_mobile/views/fishway/fish_way.dart';
import 'package:oulun_energia_mobile/views/help/help_view.dart';
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
import 'package:oulun_energia_mobile/views/newsletter/newsletter_view.dart';
import 'package:oulun_energia_mobile/views/terms/service_terms.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/usage/usage_info_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/usage/usage_settings_view.dart';
import 'package:oulun_energia_mobile/views/user/user_details.dart';

import 'widget_ext.dart';

class Config {
  static BottomNavigationBarItem Function(int, int) getHomeItem(locals) =>
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
          );

  static BottomNavigationBarItem Function(int, int) getMyUsageItem(locals) =>
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
          );

  static BottomNavigationBarItem Function(int, int) getInterruptionsItem(
          locals) =>
      (currentIndex, index) => BottomNavigationBarItem(
            icon: const Icon(
              Icons.fmd_bad_outlined,
              size: Sizes.mainViewIconSize,
            ).toBottomBarIcon(selected: currentIndex == index),
            label: locals.interruptionsViewTitle,
          );

  static BottomNavigationBarItem Function(int, int) getContactUsItem(locals) =>
      (currentIndex, index) => BottomNavigationBarItem(
            icon: const Icon(
              Icons.support_agent_outlined,
              size: Sizes.mainViewIconSize,
            ).toBottomBarIcon(selected: currentIndex == index),
            label: locals.contactUs,
          );

  static List<BottomNavigationBarItem> getUserLoggedInItems(index, locals) => [
        getHomeItem(locals),
        getMyUsageItem(locals),
        getInterruptionsItem(locals),
        getContactUsItem(locals)
      ]
          .asMap()
          .entries
          .map((entries) => entries.value(index, entries.key))
          .toList();

  static List<BottomNavigationBarItem> getUserNotLoggedInItems(index, locals) =>
      [
        getHomeItem(locals),
        getInterruptionsItem(locals),
        getContactUsItem(locals)
      ]
          .asMap()
          .entries
          .map((entries) => entries.value(index, entries.key))
          .toList();

  static List<String> userLoggedInNavbarRoutes = [
    HomeView.routeName,
    UsageSelectionsView.routeName,
    InterruptionsSelectionsView.routeName,
    ContactUsView.routeName
  ];

  static List<String> userNotLoggedInNavbarRoutes = [
    HomeView.routeName,
    InterruptionsSelectionsView.routeName,
    ContactUsView.routeName
  ];

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
      ContactUsSendMessageView.routeName:
          ContactUsSendMessageView.getSettings(context),
      ServiceTermsView.routeName: ServiceTermsView.getSettings(),
      FishWay.routeName: FishWay.getSettings(),
      HelpView.routeName: HelpView.getSettings(),
      UserDetailsView.routeName: UserDetailsView.getSettings(context),
      NewsletterView.routeName: NewsletterView.getSettings()
    };

    return settings;
  }

  static bool isLoggedIn(WidgetRef ref) {
    LoggedInStatus loggedInStatus = ref.read(loginProvider).loggedInStatus;
    return loggedInStatus == LoggedInStatus.loggedIn;
  }

  static List<BottomNavigationBarItem> getUserNavBarItems(
      BuildContext context, WidgetRef ref, int index) {
    var locals = AppLocalizations.of(context)!;
    var userIsLoggedIn = isLoggedIn(ref);
    return userIsLoggedIn
        ? getUserLoggedInItems(index, locals)
        : getUserNotLoggedInItems(index, locals);
  }

  static List<String> getUserNavBarRoutes(BuildContext context, WidgetRef ref) {
    bool userIsLoggedIn = isLoggedIn(ref);
    return userIsLoggedIn
        ? userLoggedInNavbarRoutes
        : userNotLoggedInNavbarRoutes;
  }
}
