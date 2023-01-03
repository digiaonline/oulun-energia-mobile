import 'package:flutter/material.dart';

PreferredSizeWidget usageAppBar(
        {required Function() onTap, required String title, Widget? trailing}) =>
    AppBar(
      toolbarHeight: 100,
      elevation: 0.1,
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
                  color: Colors.black,
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
