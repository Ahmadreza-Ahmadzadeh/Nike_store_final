import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/screen/auth/auth.dart';
import 'package:nike_store/screen/cart/bloc/cart_bloc.dart';
import 'package:nike_store/screen/cart/cart_price_info.dart';
import 'package:nike_store/screen/home/home.dart';
import 'package:nike_store/screen/shipping/shipping_cart.dart';
import 'package:nike_store/widgets/empty_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utility.dart';
import 'cart_show_items.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool stateFloatActionButton = false;
  late CartBloc? cartBloc;
  final RefreshController _refresher = RefreshController();
  StreamSubscription? subScriptionRefreshedState;

  @override
  void initState() {
    AuthRepository.authChangeNotifier.addListener(authListener);
    CartRepository.changeProductFromDetailScreen.addListener(countListener);
    super.initState();
  }

  void authListener() {
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  void countListener() {
    cartBloc?.add(CartStarted(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier.removeListener(authListener);
    CartRepository.changeProductFromDetailScreen.removeListener(countListener);
    cartBloc?.close();
    subScriptionRefreshedState?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("سبد خرید"),
        ),
        floatingActionButton: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Visibility(
              visible: stateFloatActionButton,
              child: FloatingActionButton.extended(
                  onPressed: () {
                    final state = cartBloc?.state;
                    if (state is CartSuccess) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShippingCart(
                                pricePayable: state.cartResponse.payablePrice,
                                priceTotal: state.cartResponse.totalPrice,
                                shippingCost: state.cartResponse.shippingCosts,
                              )));
                    }
                  },
                  label: Text(
                    "پرداخت",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            cartBloc = bloc;
            bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));

            subScriptionRefreshedState = bloc.stream.listen((state) {
              setState(() {
                stateFloatActionButton = state is CartSuccess;
              });
              if (_refresher.isRefresh) {
                if (state is CartSuccess) {
                  _refresher.refreshCompleted();
                } else {
                  _refresher.refreshFailed();
                }
              }
            });
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartSuccess) {
                return SmartRefresher(
                  onRefresh: () {
                    cartBloc?.add(CartStarted(
                        AuthRepository.authChangeNotifier.value,
                        isRefreshed: true));
                  },
                  header: const ClassicHeader(
                    completeText: "با موفقیت انجام شد",
                    idleText: "برای بروزرسانی به پایین بکشید",
                    failedText: "با مشکل مواجه شد",
                    refreshingText: "در حال بروزرسانی",
                    releaseText: "رها کنید",
                  ),
                  controller: _refresher,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                    child: ListView.builder(
                      physics: defaultPhysics,
                      itemCount: state.cartResponse.cartItems.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.cartResponse.cartItems.length) {
                          final data = state.cartResponse.cartItems[index];
                          return CartShowItems(
                            onIncreasChangeCountButton: () => cartBloc?.add(
                                CartIncreaseProductCount(data.cart_item_id)),
                            onDecreaseChangeCountButton: () => cartBloc?.add(
                                CartDecreaseProductCount(data.cart_item_id)),
                            data: data,
                            onDeleteButton: () {
                              cartBloc!.add(
                                  CartOnClickedDeleteButton(data.cart_item_id));
                            },
                          );
                        } else {
                          return CartPriceInfo(
                            pricePayable: state.cartResponse.payablePrice,
                            priceTotal: state.cartResponse.totalPrice,
                            shippingCost: state.cartResponse.shippingCosts,
                          );
                        }
                      },
                    ),
                  ),
                );
              } else if (state is CartError) {
                return Center(child: Text(state.appException.messageError));
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.appException.messageError)));
              } else if (state is CartAuthRequired) {
                return EmptuState(
                  message: " وارد حساب کاربری خود شوید",
                  image: SvgPicture.asset("assets/img/auth_required.svg",
                      width: 140),
                  callToBack: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AuthScreen()));
                    },
                    child: const Text("ورود به حساب کاربری"),
                  ),
                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.appException.messageError)));
              } else if (state is CartEmptyState) {
                return SmartRefresher(
                  onRefresh: () {
                    cartBloc?.add(CartStarted(
                        AuthRepository.authChangeNotifier.value,
                        isRefreshed: true));
                  },
                  controller: _refresher,
                  header: const ClassicHeader(
                    completeText: "با موفقیت انجام شد",
                    idleText: "برای بروزرسانی به پایین بکشید",
                    failedText: "با مشکل مواجه شد",
                    refreshingText: "در حال بروزرسانی",
                    releaseText: "رها کنید",
                  ),
                  child: EmptuState(
                      message: "هیچ محصولی یافت نشد",
                      image: SvgPicture.asset(
                        "assets/img/empty_cart.svg",
                        width: 220,
                      ),
                      callToBack: ElevatedButton(
                        child: const Text("ورود به فروشگاه"),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        ),
                      )),
                );
              } else {
                throw Exception("State not valid");
              }
            },
          ),
        )

        //   ValueListenableBuilder<AuthInfo?>(
        //     valueListenable: AuthRepository.authChangeNotifier,
        //     builder: (context, authState, child) {
        //       final bool isAutenticated =
        //           authState != null && authState.accessToken.isNotEmpty;
        //       return SizedBox(
        //         width: MediaQuery.of(context).size.width,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text(isAutenticated
        //                 ? "خوش آمدید"
        //                 : "لطفا وارد حساب کاربری خود شوید"),
        //             isAutenticated
        //                 ? ElevatedButton(
        //                     onPressed: () {
        //                       authRepository.signOut();
        //                     },
        //                     child: const Text("خروج از حساب"))
        //                 : ElevatedButton(
        //                     onPressed: () {
        //                       Navigator.of(context, rootNavigator: true)
        //                           .push(MaterialPageRoute(
        //                         builder: (context) => AuthScreen(),
        //                       ));
        //                     },
        //                     child: const Text("ورود حساب کاربری")),
        //             ElevatedButton(
        //                 onPressed: () {
        //                   authRepository.refreshToken();
        //                 },
        //                 child: Text("Refresh Tokem"))
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        );
  }
}
