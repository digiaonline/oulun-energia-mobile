import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import '../../flavors.dart';

class MainView extends StatefulWidget {
  static const String routeName = "home_page";

  const MainView({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainViewState();
  }
}

class MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(context,
          titleWidget: SvgPicture.network(
            "https://www.oulunenergia.fi/globalassets/logos/oe_navi_logo_suurempi.svg",
            color: Colors.blueAccent,
            width: 200,
          )),
      body: Center(
        child: Text(
          'Hello ${F.title}',
        ),
      ),
    );
  }
}
