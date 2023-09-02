import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/screen/list/product_list.dart';
import 'package:nike_store/screen/product/productItem.dart';

import '../../widgets/loadingImage.dart';

class HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const HorizontalProductList({
    super.key,
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductListScreen(
                          sort: ProductSort.names.indexOf(title)),
                    ));
                  },
                  child: const Text("مشاهده همه ")),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: defaultPhysics,
            padding: const EdgeInsets.only(left: 8, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(
                product: product,
                borderRadius: BorderRadius.circular(12),
              );
            },
          ),
        ),
      ],
    );
  }
}
