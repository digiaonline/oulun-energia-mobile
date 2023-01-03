import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/utils/appbar.dart';
import 'package:oulun_energia_mobile/views/utils/widget_ext.dart';

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
    var textTheme = Theme.of(context).textTheme;
    return CustomScrollView(
      slivers: [
        buildMainAppBar(
          context,
        ),
        SliverFillRemaining(
          child: Column(children: [
            Center(
              child: Text(
                'Hello ${F.title}',
                style: textTheme.bodyText1,
              ),
            ),
            /*FutureBuilder(
            initialData: Text("loading"),
            builder: (context, snapshot) =>
                IntrinsicHeight(child: snapshot.data!),
            future: LocalStorage().migrate()),*/
          ]),
        )
      ],
    ).withBackground();
  }
}
