import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/screen/product/details.dart';

import '../../data/product.dart';
import '../../widgets/loadingImage.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.borderRadius,
  });
  final BorderRadius borderRadius;
  final ProductEntity product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: widget.product),
          )),
          borderRadius: widget.borderRadius,
          child: SizedBox(
            width: 176,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 0.93,
                      child: loadingImageServer(
                        imageUrl: widget.product.image,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: InkWell(
                        onTap: () {
                          if (favoriteManager.isFavorite(widget.product)) {
                            favoriteManager.delete(widget.product);
                          } else {
                            favoriteManager.addFavorite(widget.product);
                          }
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ValueListenableBuilder<Box<ProductEntity>>(
                            valueListenable: FavoriteManager.listnable,
                            builder: (context, value, child) {
                              return Icon(
                                favoriteManager.isFavorite(widget.product)
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.product.title,
                    maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    (widget.product.previousPrice).withPriceLabel,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .apply(decoration: TextDecoration.lineThrough),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                  child: Text((widget.product.price).withPriceLabel),
                ),
              ],
            ),
          ),
        ));
  }
}
