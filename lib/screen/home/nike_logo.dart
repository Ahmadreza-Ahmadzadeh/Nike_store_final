import 'package:flutter/material.dart';

class NikeLogo extends StatelessWidget {
  const NikeLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Image.asset(
        "assets/img/nike_logo.png",
        height: 28,
        fit: BoxFit.fitHeight,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
