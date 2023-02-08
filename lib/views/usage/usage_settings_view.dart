import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oulun_energia_mobile/core/domain/usage_place.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/theme/sizes.dart';
import 'package:oulun_energia_mobile/views/usage/usage_selections_view.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:oulun_energia_mobile/views/utils/submit_button.dart';
import 'package:oulun_energia_mobile/views/utils/dropdown.dart';

class UsageSettingsView extends ConsumerStatefulWidget {
  static const String routePath = 'settings';
  static const String routeName = 'settings';

  const UsageSettingsView({Key? key}) : super(key: key);

  static Map<String, dynamic> getSettings(BuildContext context) {
    return {
      'title': AppLocalizations.of(context)!.usageViewSettings,
      'secondaryAppBar': true,
      'secondaryAppBarStyle': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  @override
  ConsumerState<UsageSettingsView> createState() => _UsageSettingsViewState();
}

class _UsageSettingsViewState extends ConsumerState<UsageSettingsView> {
  late Map<UsageType, List<UsagePlace>> _usagePlaces;
  late UsageType _selectedUsageType;
  late UsagePlace _selectedUsagePlace;
  bool _useCelsius = true;

  _onSave(BuildContext context) {
    // TODO Save locally and/or via API
    // type: ${_selectedUsageType.name}
    // address: ${_selectedUsagePlace.street}, ${_selectedUsagePlace.postPlace} ${_selectedUsagePlace.postCode}
    // useCelsius: ${_useCelsius}
    context.go(UsageSelectionsView.routePath);
  }

  _onCancel(BuildContext context) {
    context.go(UsageSelectionsView.routePath);
  }

  _onSetSelectedUsageType(dynamic usageType) {
    setState(() {
      _selectedUsageType = usageType;
    });
  }

  _onSetSelectedUsagePlace(dynamic usagePlace) {
    setState(() {
      _selectedUsagePlace = usagePlace;
    });
  }

  List<DropdownMenuItem<dynamic>> _getUsageTypeItems(AppLocalizations locals) {
    return _usagePlaces.keys.toList().map((UsageType type) {
      String text =
          type == UsageType.electric ? locals.electric : locals.districtHeating;
      return DropdownMenuItem(
          value: type,
          child: Text(
            text,
            style: textTheme.bodyLarge,
          ));
    }).toList();
  }

  List<DropdownMenuItem<dynamic>> _getUsagePlaceItems() {
    return _usagePlaces[_selectedUsageType]!.toList().map((UsagePlace type) {
      return DropdownMenuItem(
          value: type,
          child: Text(
            '${type.street}, ${type.postPlace} ${type.postCode}',
            style: textTheme.bodyLarge,
          ));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _usagePlaces = ref
        .read(loginProvider)
        .userAuth!
        .customerInfo
        .getUsagePlacesByUsageType();

    // TODO load default user settings from somewhere (:D)

    UsageType usageType = _usagePlaces.keys.toList()[0];
    _selectedUsageType = usageType;
    _selectedUsagePlace = _usagePlaces[usageType]![0];
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations locals = AppLocalizations.of(context)!;

    return Content(
      title: locals.usageViewUsagePlace,
      text: '',
      children: [
        Dropdown(
          selectedValue: _selectedUsageType,
          onChanged: _onSetSelectedUsageType,
          items: _getUsageTypeItems(locals),
          title: locals.usageViewUsageType,
        ),
        const SizedBox(height: Sizes.itemDefaultSpacing * 2),
        Dropdown(
          selectedValue: _selectedUsagePlace,
          onChanged: _onSetSelectedUsagePlace,
          items: _getUsagePlaceItems(),
          title: locals.usageViewUsagePlace,
        ),
        const SizedBox(height: Sizes.itemDefaultSpacing * 2),
        SizedBox(
          width: double.infinity,
          child: Text(
            locals.usageViewUsageChartInfo,
            style: textTheme.displayLarge,
            textAlign: TextAlign.left,
          ),
        ),
        InfoTile(
          title: locals.usageViewUsageInfo,
          subtitle: locals.usageViewUsageInfoSubText,
        ),
        InfoTile(
          title: locals.usageViewUsageTemperature,
          subtitle: locals.usageViewUsageTemperatureSubText,
          trailing: CupertinoSwitch(
            value: _useCelsius,
            onChanged: (useCelsius) => setState(() {
              _useCelsius = useCelsius;
            }),
            activeColor: secondaryActiveButtonColor,
          ),
        ),
        const SizedBox(height: Sizes.itemDefaultSpacing * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SubmitButton(
                text: locals.cancel, onPressed: () => _onCancel(context)),
            const SizedBox(width: Sizes.itemDefaultSpacing / 2),
            SubmitButton(
                text: locals.save,
                onPressed: () => _onSave(context),
                invertColors: true),
          ],
        )
      ],
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;

  const InfoTile(
      {Key? key, required this.title, required this.subtitle, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: dividerColor),
        ),
      ),
      child: ListTile(
        title: Text(title, style: textTheme.bodyLarge),
        subtitle: FittedBox(
          child: Text(subtitle,
              style: textTheme.bodyMedium?.copyWith(color: Colors.black)),
        ),
        trailing: trailing,
      ),
    );
  }
}
