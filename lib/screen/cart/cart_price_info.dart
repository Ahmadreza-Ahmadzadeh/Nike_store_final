import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';

class CartPriceInfo extends StatelessWidget {
  final int pricePayable;
  final int priceTotal;
  final int shippingCost;

  const CartPriceInfo({
    super.key,
    required this.pricePayable,
    required this.priceTotal,
    required this.shippingCost,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 12, 8),
          child: Text("جزئیات خرید",
              style: Theme.of(context).textTheme.titleSmall),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("مبلغ کل خرید"),
                    Text(priceTotal.withPriceLabel),
                  ],
                ),
              ),
              const Divider(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("هزینه ارسال"),
                    Text(shippingCost.withPriceLabel),
                  ],
                ),
              ),
              const Divider(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("مبلغ قابل پرداخت"),
                    RichText(
                        text: TextSpan(
                            text: pricePayable.seprateByComma,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                            children: [
                          TextSpan(
                              text: " تومان",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal))
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
