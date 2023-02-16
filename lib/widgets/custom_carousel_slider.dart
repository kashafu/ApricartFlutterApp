import 'package:apricart/models/home_data_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../shared/app_colors.dart';
import '../shared/helpers.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> items;
  final List<String> ids;
  final Function(String) onBannerTap;
  final double margin;
  final double height;
  final double indicatorDistance;

  const CustomCarouselSlider({
    Key? key,
    required this.items,
    required this.ids,
    required this.margin,
    required this.height,
    required this.onBannerTap,
    this.indicatorDistance = 28,
  }) : super(key: key);

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: List.generate(
            widget.items.length,
            (index) => GestureDetector(
              onTap: () {
                if (widget.items[index].isNotEmpty) {
                  widget.onBannerTap(widget.ids[index]);
                }
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: widget.margin),
                decoration: BoxDecoration(
                  color: widget.items[index].isEmpty ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                  image: widget.items[index].isEmpty
                      ? null
                      : DecorationImage(
                          image: NetworkImage(widget.items[index]),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1,
            autoPlay: widget.items.length == 1 ? false : true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: widget.indicatorDistance),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: index == currentIndex ? 25 : 13,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              decoration: BoxDecoration(
                color: index == currentIndex ? AppColors.blue : AppColors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
