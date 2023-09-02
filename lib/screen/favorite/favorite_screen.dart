import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/screen/favorite/bloc/favorite_bloc.dart';
import 'package:nike_store/screen/product/details.dart';
import 'package:nike_store/widgets/loadingImage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteBloc? favoriteBloc;
  @override
  void initState() {
    FavoriteManager.listnable.addListener(changeFavoriteListner);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    FavoriteManager.listnable.removeListener(changeFavoriteListner);
  }

  void changeFavoriteListner() {
    favoriteBloc?.add(FavoriteInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("لیست علاقه مندی ها"),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<ProductEntity>>(
          valueListenable: FavoriteManager.listnable,
          builder: (context, value, child) {
            return BlocProvider<FavoriteBloc>(create: (context) {
              final bloc = FavoriteBloc()..add(FavoriteInitial());
              favoriteBloc = bloc;
              return bloc;
            }, child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteSuccess) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      physics: defaultPhysics,
                      itemCount: state.favoriteList.length,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                          valueListenable: theme,
                          builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        product: state.favoriteList[index]),
                                  ));
                                },
                                onLongPress: () {
                                  BlocProvider.of<FavoriteBloc>(context).add(
                                      DeleteFavoriteOnHold(
                                          state.favoriteList[index]));
                                },
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground
                                                .withOpacity(0.1))
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: loadingImageServer(
                                          imageUrl:
                                              state.favoriteList[index].image,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 16, 16, 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(state
                                                .favoriteList[index].title),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              state.favoriteList[index]
                                                  .previousPrice.withPriceLabel,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                            ),
                                            Text(
                                              state.favoriteList[index].price
                                                  .withPriceLabel,
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ));
          },
        ));
  }
}
