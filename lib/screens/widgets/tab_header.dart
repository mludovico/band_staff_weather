import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {

  final String label;
  final int index;
  final int current;
  final Future<void> Function() onTap;
  final decoration = BoxDecoration(
    border: Border(
      right: BorderSide(
        color: Colors.pinkAccent,
        width: 2,
      ),
    ),
  );

  TabHeader({this.label, this.index, this.current, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 100,
          decoration: current == index ? decoration : null,
          child: Center(
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
