import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/widgets/loadingImage.dart';
import 'package:nike_store/widgets/slider.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../widgets/error_widget.dart';
import '../product/horizontalProductList.dart';
import 'bloc/home_bloc.dart';
import 'nike_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final homebloc = HomeBloc(
            bannnerRepository: bannerRepository,
            productRepository: productRepository);
        homebloc.add(HomeStarted());

        return homebloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  physics: defaultPhysics,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return NikeLogo();

                      case 2:
                        return BannerSlider(
                          banners: state.banners,
                        );

                      case 3:
                        return HorizontalProductList(
                          onTap: () {},
                          products: state.latestProduct,
                          title: "جدیدترین",
                        );
                      case 4:
                        return HorizontalProductList(
                            title: "پربازدیدترین",
                            onTap: () {},
                            products: state.pupolarProduct);
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.messageError,
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeStarted());
                  },
                );
              } else {
                throw Exception("invalid state");
              }
            },
          ),
        ),
      ),
    );
  }
}
