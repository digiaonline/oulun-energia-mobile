import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function()? onChangePage;

  const OptionButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onChangePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChangePage,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
          ),
        ),
        child: ListTile(
          leading: icon,
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 19.0,
          ),
          title: Text(text),
        ),
      ),
    );
  }
}
