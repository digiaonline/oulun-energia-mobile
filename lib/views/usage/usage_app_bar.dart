import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

PreferredSizeWidget usageAppBar(BuildContext context,
        {required Function() onTap, required String title, Widget? trailing}) =>
    AppBar(
      backgroundColor: Colors.white.withAlpha(255),
      toolbarHeight: 100,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.arrow_back,
                  color: iconColorBlue,
                ),
              ),
              trailing: trailing,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
