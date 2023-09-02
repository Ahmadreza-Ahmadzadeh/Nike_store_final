import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/screen/list/bloc/product_list_bloc.dart';
import 'package:nike_store/screen/product/productItem.dart';

enum ProductView { gird, list }

class ProductListScreen extends StatefulWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ProductView productView = ProductView.gird;
  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProductSort.names[widget.sort]),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (context) {
          bloc = ProductListBloc(productRepository)
            ..add(ProductListInitial(widget.sort));

          return bloc!;
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            return state is ProductListSuccess
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                  width: 1)),
                          color: Theme.of(context).colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.2))
                          ],
                        ),
                        height: 56,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(35))),
                                      builder: (context) {
                                        return SizedBox(
                                            height: 260,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 24, bottom: 24),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "انتخاب مرتب سازی",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            bloc?.add(
                                                                ProductListInitial(
                                                                    index));
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    16,
                                                                    8,
                                                                    16,
                                                                    8),
                                                            child: SizedBox(
                                                              height: 32,
                                                              child: Row(
                                                                children: [
                                                                  Text(state
                                                                          .sortName[
                                                                      index]),
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  if (state
                                                                          .sort ==
                                                                      index)
                                                                    Icon(
                                                                      CupertinoIcons
                                                                          .check_mark_circled_solid,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .primary,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      itemCount:
                                                          state.sortName.length,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(CupertinoIcons.sort_down),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("مرتب سازی"),
                                          Text(
                                            state.sortName[widget.sort],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Theme.of(context).dividerColor,
                                width: 1,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      productView == ProductView.gird
                                          ? productView = ProductView.list
                                          : productView = ProductView.gird;
                                    });
                                  },
                                  icon: productView != ProductView.gird
                                      ? const Icon(
                                          CupertinoIcons.square_grid_2x2)
                                      : const Icon(CupertinoIcons.square_list))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.65,
                                  crossAxisCount:
                                      productView == ProductView.gird ? 2 : 1),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: ProductItem(
                                product: state.products[index],
                                borderRadius: BorderRadius.zero,
                              ),
                            );
                          },
                        ),
                      ),
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
