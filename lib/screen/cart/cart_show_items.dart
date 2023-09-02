import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/cart_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgets/loadingImage.dart';
import 'bloc/cart_bloc.dart';

class CartShowItems extends StatelessWidget {
  final GestureTapCallback onDeleteButton;
  final GestureTapCallback onIncreasChangeCountButton;
  final GestureTapCallback onDecreaseChangeCountButton;
  final CartItemEntity data;

  const CartShowItems({
    super.key,
    required this.data,
    required this.onDeleteButton,
    required this.onIncreasChangeCountButton,
    required this.onDecreaseChangeCountButton,
  });

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Container(
      margin: const EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: Theme.of(context).colorScheme.shadow),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: loadingImageServer(
                    imageUrl: data.productEntity.image,
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.productEntity.title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "تعداد",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.apply(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: onIncreasChangeCountButton,
                          icon: const Icon(CupertinoIcons.plus_rectangle)),
                      data.loadingOnChangeCount
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Text(
                              data.count.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                      IconButton(
                          onPressed: data.count > 1
                              ? onDecreaseChangeCountButton
                              : null,
                          icon: const Icon(CupertinoIcons.minus_rectangle)),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      (data.productEntity.previousPrice).withPriceLabel,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ).copyWith(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color),
                    ),
                    Text(
                      (data.productEntity.price).withPriceLabel,
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 5,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onBackground,
                    textStyle: Theme.of(context).textTheme.bodyMedium),
                onPressed: onDeleteButton,
                child: data.loadingOnDeleting
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : const Text("حذف از سبد خرید"),
              ))
        ],
      ),
    );
  }
}
