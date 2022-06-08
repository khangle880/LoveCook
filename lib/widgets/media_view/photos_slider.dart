import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../resources/colors.dart';
import '../../utils/utils.dart';

class PhotosSlider extends StatelessWidget {
  final List<String> photoUrls;
  final EdgeInsets? itemMargin;
  final CarouselOptions? options;
  const PhotosSlider(
      {Key? key, required this.photoUrls, this.itemMargin, this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container(
      color: AppColors.grayLight,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Assets.images.png.defaultRecipe.image(),
      ),
    );
    return photoUrls.isNotEmpty
        ? CarouselSlider(
            options: options ?? CarouselOptions(height: 300.0),
            items: photoUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: itemMargin ?? EdgeInsets.zero,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: CachedNetworkImage(
                      imageUrl: AppConfig.instance.formatLink(imageUrl),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => errorWidget,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          )
        : const SizedBox.shrink();
  }
}
