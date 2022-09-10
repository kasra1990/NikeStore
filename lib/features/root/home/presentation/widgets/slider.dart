import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nike_flutter/features/root/home/domain/entities/home_data_entity.dart';
import 'package:nike_flutter/features/root/home/presentation/widgets/single_slide.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// create a banner slider
class BannerSlider extends StatefulWidget {
  final List<SliderEntity>? banners;

  const BannerSlider({Key? key, required this.banners}) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) => _createSlider();

  // Slider UI
  Widget _createSlider() {
    _autoSlide();
    return AspectRatio(
      aspectRatio: 1.8,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.banners!.length,
            itemBuilder: (context, index) =>
                Slide(banner: widget.banners![index]),
          ),
          Positioned(left: 0, right: 0, bottom: 8, child: _pageIndicator())
        ],
      ),
    );
  }

  // indicator for slider
  Widget _pageIndicator() {
    return Center(
        child: SmoothPageIndicator(
      controller: _controller,
      count: widget.banners!.length,
      axisDirection: Axis.horizontal,
      effect: WormEffect(
          spacing: 4,
          radius: 4.0,
          dotWidth: 18.0,
          dotHeight: 3.0,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          dotColor: Colors.grey.shade300,
          activeDotColor: Colors.black54),
    ));
  }

  ///Create timer for slider
  void _autoSlide() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.page!.round() + 1 < widget.banners!.length) {
        _controller.animateToPage(_controller.page!.round() + 1,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        _controller.jumpToPage(0);
      }
    });
  }
}
