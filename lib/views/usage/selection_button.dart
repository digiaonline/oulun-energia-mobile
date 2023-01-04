import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final Widget widget;
  final Function()? onChangePage;

  const SelectionButton(
      {Key? key,
      required this.text,
      required this.widget,
      required this.onChangePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
        ),
      ),
      child: ListTile(
        onTap: onChangePage,
        leading: widget,
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 19.0,
        ),
        title: Text(text),
      ),
    );
  }
}
