import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/views/theme/default_theme.dart';

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.title,
    required this.text,
    this.image,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String title;
  final String text;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null) image!,
            // TODO Show the image here if assigned
            //  Container is a placeholder for the image for now
            Container(
              color: Colors.grey,
              width: double.infinity,
              height: 235.0,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        title,
                        style:
                            textTheme.headline1?.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      text,
                      style: defaultTheme.textTheme.bodyText2,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: children,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
