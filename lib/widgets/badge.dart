import 'package:flutter/material.dart';

class BadgeCart extends StatelessWidget {
  final int value;

  const BadgeCart({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value > 0,
      child: Container(
        alignment: Alignment.center,
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          value.toString(),
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 11),
        ),
      ),
    );
  }
}
