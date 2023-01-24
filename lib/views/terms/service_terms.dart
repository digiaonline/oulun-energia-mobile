import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/base/base_fullscreen_widget.dart';
import 'package:oulun_energia_mobile/views/login/login_view.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/default_theme.dart';

class ServiceTermsView extends StatelessWidget {
  static const String routePath = "service_terms";
  static const String routeName = "service_terms";

  const ServiceTermsView({super.key}) : super();

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': false,
      'initialExpanded': false,
      'hideAppBar': true,
    };
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BaseFullScreenWidget(LoginView.routePath,
        appBarTitle: "Käyttöehdot",
        title: "Sovelluksen käyttöehdot",
        description:
            "Oulun Energia -sovelluksen (myöhemmin palvelu) omistaa... Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus at velit nec sagittis. Donec libero tellus, volutpat sed nisi eget, posuere gravida purus."
            "Nam eu mi eget odio fermentum hendrerit. Sed malesuada consequat lacus, at elementum velit sagittis nec. Ut euismod rhoncus justo, sed luctus dui venenatis quis. Pellentesque convallis arcu ac tempus varius."
            "Sed varius sapien placerat, aliquam urna sed, venenatis est. Morbi in vestibulum eros. Mauris aliquam nibh id ullamcorper dictum. Morbi non augue vitae dui porta imperdiet quis nec purus. Maecenas gravida tempor enim.",
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Lisätietoja käyttöehdoista",
            style: theme.textTheme.headline4?.copyWith(
                fontWeight: FontWeight.w400, color: containerTitleColor),
          ),
          const SizedBox(
            height: Sizes.itemDefaultSpacing,
          ),
          Container(
            color: containerColor,
            padding: const EdgeInsets.all(Sizes.itemDefaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Oulun Energia",
                  style:
                      theme.textTheme.headline3?.copyWith(color: Colors.black),
                ),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                        text: "Nahkatehtaankatu 2 \nPL 116, 90101 Oulu\n"
                            "Puhelin, vaihde:"),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text("08 5584 3300",
                              style: theme.textTheme.bodyText1?.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: iconColorBlueLight))
                          .toClickable(
                              onTap: () =>
                                  launchUrl(Uri.parse("tel:08 5584 3300"))),
                    ),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          "info@oulunenergia.fi",
                          style: theme.textTheme.bodyText1?.copyWith(
                              decoration: TextDecoration.underline,
                              color: iconColorBlueLight),
                        ).toClickable(onTap: () {
                          launchUrl(Uri.parse("mailto:info@oulunenergia.fi"));
                        })),
                    TextSpan(
                        text: "\ny-tunnus: 0989376-5",
                        style: theme.textTheme.bodyText1),
                  ]),
                ),
              ],
            ),
          )
        ]));
  }
}
