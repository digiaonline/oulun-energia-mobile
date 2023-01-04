import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/views/usage/selection_button.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsageSelectionsView extends StatelessWidget {
  static String routeName = 'usage_selections_view';
  final Function(MyUsageViews) onChangePage;

  const UsageSelectionsView({Key? key, required this.onChangePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildMainAppBar(
        context,
        titleWidget: SvgPicture.asset(
          'assets/images/oe_logo.svg',
          color: const Color(0xFF0F5EA6),
          width: 200,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey,
            height: 200,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      AppLocalizations.of(context)!.usageViewMyConsumption,
                      style: const TextStyle(
                        color: Color(0xFF1A1C1E),
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nam eu mi eget odio fermentum hendrerit. Sed malesuada consequat lacus, at elementum velit sagittis nec. Ut euismod rhoncus justo, sed luctus dui venenatis quis. Pellentesque convallis arcu ac tempus varius.',
                    style: TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 0.25,
                      color: Color(0xFF1A1C1E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SelectionButton(
                    onChangePage: () => onChangePage(MyUsageViews.info),
                    text: AppLocalizations.of(context)!.usageViewUsageInfo,
                    widget: SvgPicture.asset('assets/icons/monitoring.svg',
                        width: 28.0, height: 28.0),
                  ),
                  SelectionButton(
                    onChangePage: () => onChangePage(MyUsageViews.settings),
                    text: AppLocalizations.of(context)!.usageViewSettings,
                    widget: const Icon(
                      Icons.settings_outlined,
                      color: Colors.black,
                      size: 28.0,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
