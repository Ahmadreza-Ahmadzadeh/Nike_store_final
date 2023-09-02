import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/appExeption.dart';

class AppErrorWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final AppException exception;

  const AppErrorWidget({
    super.key,
    required this.onTap,
    required this.exception,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.messageError),
          ElevatedButton(onPressed: onTap, child: Text("تلاش دوباره"))
        ],
      ),
    );
  }
}
