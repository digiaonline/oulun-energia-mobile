import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oulun_energia_mobile/core/authentication/authentication.dart';
import 'package:oulun_energia_mobile/core/domain/usage.dart';
import 'package:oulun_energia_mobile/core/domain/user_auth.dart';
import 'package:oulun_energia_mobile/core/enums.dart';
import 'package:oulun_energia_mobile/core/network_api/usage_api.dart';
import 'package:oulun_energia_mobile/views/utils/string_utils.dart';
import 'package:oulun_energia_mobile/flavors.dart';

const json = {
  "customer_info": {
    "company_name": "",
    "customer_codes": ["3036092"],
    "email": "mira.juola@icloud.com",
    "first_name": "Mira",
    "last_name": "Juola",
    "name": "Mira Juola",
    "phone": "+358408355262",
    "postcode": "90940",
    "postplace": "JÄÄLI",
    "street": "Anjantie 23",
    "usage_places": [
      {
        "company": true,
        "contracts": [
          {"end_date": null, "start_date": "2022-09-26T21:00:00Z"}
        ],
        "id": "643007486000841898",
        "network": "OE0000",
        "postcode": "90940",
        "postplace": "JÄÄLI",
        "street": "Anjantie 23",
        "type": "Sähkö"
      }
    ]
  },
  "etoken":
      "eyJhbGciOiJIUzI1NiJ9.eyJjdXN0b21lcl9jb2RlcyI6WyIzMDM2MDkyIl0sImlkIjoibWlyYS5qdW9sYUBpY2xvdWQuY29tIn0.6lG326dSKUj13a_CZLucDdeQSJhlouHz3C8kmnGKvGw",
  "first_login": false
};

class UsageDataView extends StatefulWidget {
  static String routeName = 'usage_data_view';
  final Function(int) onChangePage;

  const UsageDataView({Key? key, required this.onChangePage}) : super(key: key);

  @override
  State<UsageDataView> createState() => _UsageDataViewState();
}

class _UsageDataViewState extends State<UsageDataView> {
  DateTime current = DateTime.now();

  Future<List<Usage>> getUsages() async {
    UsageApi usageApi = UsageApi(Authentication(), F.baseUrl);
    UserAuth userAuth = UserAuth.fromJson(json);

    List<Usage> usages = await usageApi.getElectricUsage(
        userAuth,
        userAuth.customerInfo.usagePlaces[0],
        DateTime.utc(2022, 12, 1, 0),
        DateTime.utc(2022, 12, 1, 23),
        UsageInterval.interval);
    return usages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        leading: InkWell(
          onTap: () => widget.onChangePage(0),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(AppLocalizations.of(context)!.usageViewUsageData),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: const Icon(Icons.help),
          ),
        ],
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ListTile(
              title: Center(
                child: Text('123123 kWh'),
              ),
            ),
            ListTile(
              iconColor: Colors.black,
              leading: const Icon(Icons.arrow_back_ios),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: Center(
                child: Text(
                  '${StringUtils.getMonthString(current.month, context)} ${current.year}',
                  style: const TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                Center(
                  child: Text(AppLocalizations.of(context)!.usageViewHour),
                ),
                Center(
                  child: Text(AppLocalizations.of(context)!.usageViewDay),
                ),
                Center(
                  child: Text(AppLocalizations.of(context)!.usageViewMonth),
                ),
                Center(
                  child: Text(AppLocalizations.of(context)!.usageViewYear),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 15.0),
              child: Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Color(0xFFE0E0E0), width: 5.0),
                    )),
                  ),
                  TabBar(
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 5.0,
                        color: Color(0xFF009EB5),
                      ),
                    ),
                    unselectedLabelColor: Colors.black,
                    labelColor: const Color(0xFF009EB5),
                    tabs: <Widget>[
                      Tab(
                        text: AppLocalizations.of(context)!.usageViewHour,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.usageViewDay,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.usageViewMonth,
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.usageViewYear,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
