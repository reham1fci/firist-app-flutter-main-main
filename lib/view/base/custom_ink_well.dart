import 'package:flutter/material.dart';
class CustomInkWell extends StatelessWidget {
  final double? radius;
  final Widget child;
  final Function()?  onTap;
  final Color? highlightColor;
  const CustomInkWell({Key? key, this.radius,required this.child, this.onTap, this.highlightColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap ?? (){},
        borderRadius: BorderRadius.circular(radius??0.0),
        highlightColor: Theme.of(context).cardColor,
        hoverColor: Theme.of(context).primaryColor,
        child: child,
      ),
    );
  }
}
