import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../data/data.dart';
import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../resources/colors.dart';
import '../../utils/utils.dart';
import '../widgets.dart';

class BottomAddPost extends StatefulWidget {
  final User? userInfor;
  final Function(String, List<String>, List<String>)? onPostCall;

  const BottomAddPost({Key? key, required this.userInfor, this.onPostCall})
      : super(key: key);

  @override
  State<BottomAddPost> createState() => _BottomAddPostState();
}

class _BottomAddPostState extends State<BottomAddPost> {
  List<String> currentListImage = [];
  List<String> currentListVideo = [];
  String content = '';

  User? get userInfor => widget.userInfor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            _buildAppBar(context),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserRowInfor(userInfor: userInfor),
                      SizedBox(
                        height: 15,
                      ),
                      _buildInputContent(),
                      SizedBox(
                        height: 15,
                      ),
                      currentListImage.isNotEmpty
                          ? _buildListImage()
                          : SizedBox.shrink(),
                      currentListVideo.isNotEmpty
                          ? _buildVideoSlide()
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CustomIconButton(
                            icon: Assets.images.svg.icPickPhoto
                                .svg(color: Color(0xFF73777B)),
                            onTap: () async {
                              _multiImagePick();
                            },
                          ),
                          SizedBox(width: 5),
                          CustomIconButton(
                            icon: Assets.images.svg.video
                                .svg(color: Color(0xFF73777B)),
                            onTap: () async {
                              _multiVideoPick();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  CarouselSlider _buildVideoSlide() {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0, enableInfiniteScroll: false),
      items: currentListVideo.map((videoData) {
        return Builder(
          builder: (BuildContext context) {
            return VideoWidget(
              file: videoData.contains('/storage') ? videoData : null,
              path: !videoData.contains('/storage')
                  ? AppConfig.instance.formatLink(videoData)
                  : null,
            );
          },
        );
      }).toList(),
    );
  }

  Row _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
          ),
        ),
        Expanded(flex: 2, child: 'Create new post'.s20w600()),
        Expanded(
          flex: 1,
          child: MaterialInkwellButton(
            title: 'Post',
            hasBorder: false,
            constraints: BoxConstraints(minWidth: 100, maxHeight: 40),
            onTap: () {
              widget.onPostCall
                  ?.call(content, currentListImage, currentListVideo);
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: 5,
        )
      ],
    );
  }

  CarouselSlider _buildListImage() {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0),
      items: currentListImage.map((imageData) {
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

  TextField _buildInputContent() {
    return TextField(
      enabled: true,
      style: ''.s15w400style(color: AppColors.blackDarken),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: (value) {
        content = value;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "What's on your mind?",
        hintStyle: ''.s15w400style(
          color: AppColors.grayLight,
        ),
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }

  void _multiImagePick() async {
    final List<AssetEntity> result = await AssetPicker.pickAssets(
          context,
          pickerConfig: const AssetPickerConfig(requestType: RequestType.image),
        ) ??
        [];

    for (final image in result) {
      final file = await image.originFile;

      if (file != null) {
        currentListImage.add(file.path);
      }
    }

    setState(() {});
  }

  void _multiVideoPick() async {
    final List<AssetEntity> result = await AssetPicker.pickAssets(
          context,
          pickerConfig: const AssetPickerConfig(requestType: RequestType.video),
        ) ??
        [];

    for (final video in result) {
      final file = await video.originFile;

      if (file != null) {
        currentListVideo.add(file.path);
      }
    }

    setState(() {});
  }
}

class UserRowInfor extends StatelessWidget {
  const UserRowInfor({
    Key? key,
    required this.userInfor,
  }) : super(key: key);

  final User? userInfor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
            imageUrl: userInfor!.avatarUrl!.isEmpty
                ? "https://i.pravatar.cc/300"
                : userInfor!.avatarUrl!),
        SizedBox(
          width: 5,
        ),
        userInfor?.name != null
            ? userInfor!.name!.s20w700(color: Color(0xFF646FD4))
            : Text('')
      ],
    );
  }
}
