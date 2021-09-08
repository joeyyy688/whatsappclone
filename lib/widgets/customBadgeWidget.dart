import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    Key? key,
    required this.child,
    required this.item,
    this.color,
  }) : super(key: key);

  final Widget child;
  final Widget item;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 3,
          //top: 8,
          bottom: 17,
          child: Container(
              padding: EdgeInsets.all(0.0),
              //margin: EdgeInsets.all(1.0),
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: color != null ? color : Theme.of(context).accentColor,
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: item),
        )
      ],
    );
  }
}
