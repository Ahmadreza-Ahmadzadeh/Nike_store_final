import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/widgets/loadingImage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final PageController _controller = PageController();
  final List<BannerEntity> banners;
  BannerSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            physics: defaultPhysics,
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(right: 12, left: 12),
                  child: Slider(banners: banners[index]));
            },
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 5.0,
                    radius: 4.0,
                    dotWidth: 20.0,
                    dotHeight: 4.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Slider extends StatelessWidget {
  const Slider({
    super.key,
    required this.banners,
  });

  final BannerEntity banners;

  @override
  Widget build(BuildContext context) {
    return loadingImageServer(
      imageUrl: banners.image,
      borderRadius: BorderRadius.circular(14),
    );
  }
}
