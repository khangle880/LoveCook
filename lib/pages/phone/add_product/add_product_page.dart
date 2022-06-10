import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lovecook/extensions/extensions.dart';

import '../../../blocs/blocs.dart';
import '../../../core/base/base.dart';
import '../../../data/data.dart';
import '../../../gen/assets.gen.dart';
import '../../../resources/resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_dialog/app_dialog.dart';
import '../../../widgets/widgets.dart';

class AddProductPage extends StatefulWidget {
  final AddProductBloc bloc;
  const AddProductPage(this.bloc);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends BaseState<AddProductPage, AddProductBloc> {
  final _formKey = GlobalKey<FormState>();
  bool _isUpdate = false;

  @override
  AddProductBloc get bloc => widget.bloc;

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is ProductModel?) {
      if (payload == null) {
        bloc.init();
      } else {
        _isUpdate = true;
        bloc.loadProduct(payload);
      }
    }
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: "${_isUpdate ? "Update" : "Create"} product".s20w600(),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<AddProductState>(
          stream: bloc.stateStream,
          builder: (context, snp) {
            if (!snp.hasData || snp.data?.lookup == null)
              return Center(
                child: CircularProgressIndicator(),
              );
            final lookup = snp.data!.lookup!;
            final state = snp.data!;
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Product detail".s24w700(),
                        SizedBox(height: 20),
                        //? Name
                        "Product name".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        InputTextWidget(
                          initValue: state.name,
                          hintText: 'Nồi chiên không dầu',
                          onChanged: (value) {
                            bloc.updateField(name: value);
                          },
                        ),
                        SizedBox(height: 20),
                        //? Description
                        "Description".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        InputTextWidget(
                          initValue: state.description,
                          hintText:
                              'Nồi chiên không dầu Philips sẽ sử dụng không khí nóng để chiên món ăn giòn rụm với lượng chất béo đến 90%...',
                          maxLine: 4,
                          onChanged: (value) {
                            bloc.updateField(description: value);
                          },
                        ),
                        SizedBox(height: 20),
                        "Product Type".s14w600(color: AppColors.successDarken),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: PickLookup<ProductTypeModel>(
                            value: state.productType,
                            hintText: 'Dụng cụ nấu ăn',
                            items: lookup.productTypes!,
                            getText: (item) => item.names!.join(' - '),
                            onChanged: (value) {
                              bloc.updateField(productType: value);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        //? price, unit
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFDAEAF1),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  )),
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Price"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: InputTextWidget(
                                      initValue: state.price == null
                                          ? null
                                          : state.price.toString(),
                                      hintText: '10000',
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        bloc.updateField(
                                          price: double.tryParse(value),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 30),
                                  "--".s20w600(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Currency Unit"
                                      .s14w600(color: AppColors.successDarken),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: PickLookup<String>(
                                      value: state.currencyUnit,
                                      items: [
                                        "₫ (VND)",
                                        "\$ (USD)",
                                        "€ (EUR)",
                                        "¥ (JPY)",
                                        "¥ (CNY)",
                                        "\$ (SGD)",
                                        "₩ (KRW)",
                                      ],
                                      getText: (item) => item,
                                      hintText: "₫ (VND)",
                                      onChanged: (value) {
                                        bloc.updateField(
                                          currencyUnit: value,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        buildListImage(state.photoUrls ?? []),
                        const SizedBox(height: 10),
                        buildVideo(state.videoUrl),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlineButton(
                              onPressed: () async {
                                final photoUrls = await multiImagePick(context);
                                if (photoUrls.isNotEmpty) {
                                  bloc.updateField(photoUrls: photoUrls);
                                }
                              },
                              color: Color(0xFFDAEAF1),
                              height: 100,
                              width: 100,
                              contentBuilder: (color) => Assets
                                  .images.svg.icPickPhoto
                                  .svg(color: Color(0xFF73777B), height: 40),
                            ),
                            SizedBox(width: 10),
                            OutlineButton(
                              onPressed: () async {
                                final videoUrl = await singleVideoPick(context);
                                var thumnail;
                                if (videoUrl != null) {
                                  Future.delayed(
                                    Duration(milliseconds: 1000),
                                    () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AppInformationDialog(
                                        content: "Choose a thumnail for video",
                                      ),
                                    ),
                                  );
                                  thumnail = await singleImagePick(context);
                                }
                                if (videoUrl != null && thumnail != null) {
                                  bloc.updateField(
                                    videoUrl: videoUrl,
                                    videoThumbnail: thumnail,
                                  );
                                }
                              },
                              color: Color(0xFFDAEAF1),
                              height: 100,
                              width: 100,
                              contentBuilder: (color) => Assets.images.svg.video
                                  .svg(color: Color(0xFF73777B), height: 40),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        //? Submit
                        MaterialInkwellButton(
                            title: 'Submit',
                            hasBorder: false,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                var value = await bloc.saveProduct();
                                await Future.delayed(
                                    Duration(milliseconds: 1000));
                                Navigator.pop(context, value);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => AppInformationDialog(
                                      content:
                                          "You need fullfill form before save!"),
                                );
                              }
                            }),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildListImage(List<String> filePaths) {
    if (filePaths.isEmpty) return SizedBox.shrink();
    return CarouselSlider(
      options: CarouselOptions(height: 300.0),
      items: filePaths.map((imageData) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.transparent),
              child: imageData.contains('/storage')
                  ? Image.file(File(imageData), fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: AppConfig.instance.formatLink(imageData),
                      fit: BoxFit.cover,
                    ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildVideo(String? videoPath) {
    if (videoPath == null) return SizedBox.shrink();
    return Builder(
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: VideoWidget(
            file: videoPath.contains('/storage') ? videoPath : null,
            path: !videoPath.contains('/storage')
                ? AppConfig.instance.formatLink(videoPath)
                : null,
          ),
        );
      },
    );
  }
}
