import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/screen/cart/cart_price_info.dart';
import 'package:nike_store/screen/payment_webView.dart';
import 'package:nike_store/screen/receipt/reciept.dart';
import 'package:nike_store/screen/shipping/bloc/shipping_bloc.dart';

import '../../data/repo/order_repository.dart';

class ShippingCart extends StatefulWidget {
  final int pricePayable;
  final int priceTotal;
  final int shippingCost;

  const ShippingCart(
      {super.key,
      required this.pricePayable,
      required this.priceTotal,
      required this.shippingCost});

  @override
  State<ShippingCart> createState() => _ShippingCartState();
}

class _ShippingCartState extends State<ShippingCart> {
  final TextEditingController firstName = TextEditingController(text: "اشکان");
  final TextEditingController lastName = TextEditingController(text: "ابوی");
  final TextEditingController phoneNumber =
      TextEditingController(text: "01234569745");
  final TextEditingController address =
      TextEditingController(text: "شیشیشیشیشیش11111یشیشیشیشیشیشی1ی11یش1");
  final TextEditingController portalCode =
      TextEditingController(text: "0123456789");
  StreamSubscription? blocStreamSubscription;

  @override
  void dispose() {
    // TODO: implement dispose
    blocStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("شیوه پرداخت"),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (BuildContext context) {
          final bloc = ShippingBloc(orderRepository);
          blocStreamSubscription = bloc.stream.listen((state) {
            if (state is ShippingError) {
              ScaffoldMessengerState().showSnackBar(
                  SnackBar(content: Text(state.appException.messageError)));
            } else if (state is ShippingSuccess) {
              if (state.orderResult.bankGatewayUrl.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentWebViewPage(
                      bankGetUrl: state.orderResult.bankGatewayUrl),
                ));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ReceiptScreen(orderId: state.orderResult.orderId),
                ));
              }
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: firstName,
                decoration: InputDecoration(
                    label: const Text("نام"),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1)))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: lastName,
                decoration: InputDecoration(
                    label: const Text("نام خانوادگی"),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1)))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: portalCode,
                decoration: InputDecoration(
                    label: const Text("کدپستی"),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1)))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: phoneNumber,
                decoration: InputDecoration(
                    label: const Text("شماره تماس"),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1)))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: address,
                decoration: InputDecoration(
                    hintText: "تهران - کوچه یاس - پلاک 20",
                    label: const Text("آدرس تحویل گیرنده"),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1)))),
              ),
              CartPriceInfo(
                  pricePayable: widget.pricePayable,
                  priceTotal: widget.priceTotal,
                  shippingCost: widget.shippingCost),
              const SizedBox(
                height: 12,
              ),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context).add(
                                      ShippingCreateOrder(OrderParams(
                                          firstName.text,
                                          lastName.text,
                                          portalCode.text,
                                          phoneNumber.text,
                                          address.text,
                                          PaymentMethode.online)));
                                },
                                child: const Text("پرداخت اینترنتی")),
                            const SizedBox(
                              width: 12,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context).add(
                                      ShippingCreateOrder(OrderParams(
                                          firstName.text,
                                          lastName.text,
                                          portalCode.text,
                                          phoneNumber.text,
                                          address.text,
                                          PaymentMethode.cashOnDelivery)));
                                },
                                child: const Text("پرداخت در محل")),
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
