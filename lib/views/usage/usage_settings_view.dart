import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/core/domain/usage_place.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/providers/login_provider.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';
import 'package:oulun_energia_mobile/views/utils/dropdown.dart';

class UsageSettingsView extends ConsumerStatefulWidget {
  static const String routeName = 'usage_settings_view';

  const UsageSettingsView({Key? key}) : super(key: key);

  @override
  ConsumerState<UsageSettingsView> createState() => _UsageSettingsViewState();
}

class _UsageSettingsViewState extends ConsumerState<UsageSettingsView> {
  late Map<UsageType, List<UsagePlace>> _usagePlaces;
  late UsageType _selectedUsageType;
  late UsagePlace _selectedUsagePlace;
  bool _useCelsius = true;

  _onSave() {
    // TODO Save locally or via API
    print(
        'type: ${_selectedUsageType.name} place: ${_selectedUsagePlace.street}, ${_selectedUsagePlace.postPlace} ${_selectedUsagePlace.postCode} celsius: $_useCelsius');
  }

  _onCancel(BuildContext context) {
    // TODO how to handle navigator key etc pop?
    // Pass as props?
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
            style: textTheme.bodyText1,
          ));
    }).toList();
  }

  List<DropdownMenuItem<dynamic>> _getUsagePlaceItems() {
    return _usagePlaces[_selectedUsageType]!.toList().map((UsagePlace type) {
      return DropdownMenuItem(
          value: type,
          child: Text(
            '${type.street}, ${type.postPlace} ${type.postCode}',
            style: textTheme.bodyText1,
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

    // TODO load default user settings

    UsageType usageType = _usagePlaces.keys.toList()[0];
    _selectedUsageType = usageType;
    _selectedUsagePlace = _usagePlaces[usageType]![0];
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations locals = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                locals.usageViewUsagePlace,
                style: textTheme.headline1,
                textAlign: TextAlign.left,
              ),
            ),
            Dropdown(
              selectedValue: _selectedUsageType,
              onChanged: _onSetSelectedUsageType,
              items: _getUsageTypeItems(locals),
              title: locals.usageViewUsageType,
            ),
            const SizedBox(height: 30.0),
            Dropdown(
              selectedValue: _selectedUsagePlace,
              onChanged: _onSetSelectedUsagePlace,
              items: _getUsagePlaceItems(),
              title: locals.usageViewUsagePlace,
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: Text(
                locals.usageViewUsageChartInfo,
                style: textTheme.headline1,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: dividerColor),
                ),
              ),
              child: ListTile(
                title:
                    Text(locals.usageViewUsageInfo, style: textTheme.bodyText1),
                subtitle: FittedBox(
                  child: Text(locals.usageViewUsageInfoSubText,
                      style:
                          textTheme.bodyText2?.copyWith(color: Colors.black)),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: dividerColor),
                ),
              ),
              child: ListTile(
                title: Text(locals.usageViewUsageTemperature,
                    style: textTheme.bodyText1),
                subtitle: FittedBox(
                  child: Text(locals.usageViewUsageTemperatureSubText,
                      style:
                          textTheme.bodyText2?.copyWith(color: Colors.black)),
                ),
                trailing: CupertinoSwitch(
                  value: _useCelsius,
                  onChanged: (useCelsius) => setState(() {
                    _useCelsius = useCelsius;
                  }),
                  activeColor: secondaryActiveButtonColor,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100.0,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: secondaryActiveButtonColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        side: const BorderSide(
                          color: secondaryActiveButtonColor,
                        )),
                    onPressed: () => _onCancel,
                    child: Text(
                      locals.cancel,
                      style: textTheme.headline3,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  width: 100.0,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: secondaryActiveButtonColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        side: const BorderSide(
                          color: secondaryActiveButtonColor,
                        )),
                    onPressed: () => _onSave(),
                    child: Text(
                      locals.save,
                      style: textTheme.headline3,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
