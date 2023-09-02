import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/repo/reciept_repository.dart';
import 'package:nike_store/screen/receipt/bloc/reciept_bloc.dart';

class ReceiptScreen extends StatefulWidget {
  final int orderId;

  const ReceiptScreen({super.key, required this.orderId});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  StreamSubscription? streamSubscription;

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("رسید پرداخت"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) {
          final bloc = RecieptBloc(recieptRepository);
          bloc.add(RecieptCheckout(widget.orderId));
          streamSubscription = bloc.stream.listen((state) {
            if (state is RecieptReturn) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            } else if (state is RecieptError) {
              ScaffoldMessengerState().showSnackBar(
                  SnackBar(content: Text(state.appException.messageError)));
            }
          });
          return bloc;
        },
        child: BlocBuilder<RecieptBloc, RecieptState>(
          builder: (context, state) {
            return state is RecieptSuceess
                ? Column(
                    children: [
                      Container(
                        // height: 150,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.shadow)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                state.recieptResult.paymetStatus,
                                style: themeData.textTheme.titleLarge?.copyWith(
                                    color: themeData.colorScheme.primary),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "وضعیت سفارش",
                                    style: themeData.textTheme.titleSmall,
                                  ),
                                  Text(
                                    state.recieptResult.purchaseSucees
                                        ? "پرداخت شده"
                                        : "پرداخت نشده",
                                    style: themeData.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 32,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "مبلغ",
                                    style: themeData.textTheme.titleSmall,
                                  ),
                                  Text(
                                    state.recieptResult.pricePayable
                                        .seprateByComma,
                                    style: themeData.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<RecieptBloc>(context)
                                .add(RecieptReturnHome());
                          },
                          child: const Text("بازگشت به صفحه اصلی")),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
