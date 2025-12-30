import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TableCell2 extends StatelessWidget {
  final String text;
  final int flex;
  final bool isHeader;

    TableCell2({super.key,
    required this.text,
    required this.flex,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          isHeader ? text.tr : text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
