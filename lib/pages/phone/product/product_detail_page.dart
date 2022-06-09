import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../extensions/extensions.dart';
import '../../../gen/assets.gen.dart';
import '../../../resources/resources.dart';
import '../../../utils/app_config.dart';
import '../../../widgets/widgets.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final ProductModel product;
  @override
  void didChangeDependencies() {
    if (mounted) {
      final payload = ModalRoute.of(context)?.settings.arguments;
      if (payload is ProductModel) {
        product = payload;
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Sản phẩm'.s18w600(),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ProductMediaView(item: product),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      product.name!.s16w500(),
                      SizedBox(height: 5),
                      (NumberFormat("#,##0.00", "tr-TR").format(product.price) +
                              " " +
                              product.currencyUnit!)
                          .s14w500(color: Colors.red),
                      SizedBox(height: 5),
                      "Mô tả sản phẩm".s16w500(),
                      product.description!.s12w400(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductMediaView extends StatelessWidget {
  const ProductMediaView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    if (item.videoUrl != null) {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: VideoWidget(
          path: AppConfig.instance.formatLink(item.videoUrl!),
          backgroundColor: AppColors.blurDark,
          allowFullScreen: true,
        ),
      );
    }
    return PhotosSlider(
      photoUrls: item.photoUrls ?? [],
      options: CarouselOptions(
        autoPlay: true,
      ),
    );
  }
}
