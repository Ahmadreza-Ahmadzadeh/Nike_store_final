import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/screen/cart/bloc/cart_bloc.dart';
import 'package:nike_store/screen/product/bloc/product_bloc.dart';
import 'package:nike_store/screen/product/comment/comment_list.dart';
import 'package:nike_store/widgets/loadingImage.dart';
import 'package:nike_store/widgets/theme.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  GlobalKey<ScaffoldMessengerState> _messengerKey = GlobalKey();
  StreamSubscription<ProductState>? streamSubscription;
  @override
  void dispose() {
    _messengerKey.currentState?.dispose();
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          streamSubscription = bloc.stream.listen((state) {
            if (state is ProductButtonSuccess) {
              _messengerKey.currentState?.showSnackBar(const SnackBar(
                  content: Text("محصول با موفقیت به سبد خرید اضافه شد")));
            } else if (state is ProductButtonError) {
              _messengerKey.currentState?.showSnackBar(const SnackBar(
                  content: Text("افزودن محصول با مشکل مواجه شده")));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _messengerKey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return FloatingActionButton.extended(
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(ProductAddCart(widget.product.id));
                      },
                      label: state is ProductButtonLoading
                          ? CupertinoActivityIndicator()
                          : Text(
                              "افزودن به سبد خرید",
                              style: Theme.of(context).textTheme.bodyText2,
                            ));
                },
              ),
            ),
            body: CustomScrollView(
              physics: defaultPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace:
                      loadingImageServer(imageUrl: widget.product.image),
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          if (favoriteManager.isFavorite(widget.product)) {
                            favoriteManager.delete(widget.product);
                          } else {
                            favoriteManager.addFavorite(widget.product);
                          }
                          setState(() {});
                        },
                        child: ValueListenableBuilder<Box<ProductEntity>>(
                          valueListenable: FavoriteManager.listnable,
                          builder: (context, value, child) {
                            return Icon(
                              favoriteManager.isFavorite(widget.product)
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: Theme.of(context).colorScheme.onSecondary,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                (widget.product.previousPrice).withPriceLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough),
                              ),
                              Text((widget.product.price).withPriceLabel),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        " این کتونی بسیار خوب میباشد و دارای جنس ابریشم است و میتواند در اعماق آب از آن استفاده شود بدون اسیب جدی به آن وارد شود پیشنهاد ویژه ما استفاده این کفش با ضمانت معتبر و در صورت خرایی تعویض کفش صورت میگیرد  ",
                        maxLines: 2,
                        style: TextStyle(height: 1.2),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("نظرات کاربران",
                              style: Theme.of(context).textTheme.subtitle2),
                          TextButton(
                              onPressed: () {},
                              child: const Text("مشاهده همه")),
                        ],
                      ),
                    ]),
                  ),
                ),
                CommentList(productId: widget.product.id)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
