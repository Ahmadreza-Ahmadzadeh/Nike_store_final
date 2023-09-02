import 'package:flutter/material.dart';

class EmptuState extends StatelessWidget {
  final String message;
  final Widget? callToBack;
  final Widget image;

  const EmptuState(
      {super.key, required this.message, this.callToBack, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(height: 1.2),
                textAlign: TextAlign.center,
              ),
            ),
            if (callToBack != null) callToBack!,
          ],
        ),
      ),
    );
  }
}
