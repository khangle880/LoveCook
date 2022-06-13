import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../data/data.dart';
import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../resources/colors.dart';
import '../widgets.dart';

class BottomAddPost extends StatefulWidget {
  final User? userInfor;
  final Function(String, List<String>, String?)? onPostCall;

  const BottomAddPost({Key? key, required this.userInfor, this.onPostCall})
      : super(key: key);

  @override
  State<BottomAddPost> createState() => _BottomAddPostState();
}

class _BottomAddPostState extends State<BottomAddPost> {
  List<String> currentListImage = [];
  String? currentVideo;
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
                      MediaSliderWidget(
                        videoPath: currentVideo,
                        photoPaths: currentListImage,
                        showHeader: true,
                      ),
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
              widget.onPostCall?.call(content, currentListImage, currentVideo);
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
    final List<AssetEntity?> result = await AssetPicker.pickAssets(
          context,
          pickerConfig: const AssetPickerConfig(
              requestType: RequestType.video, maxAssets: 1),
        ) ??
        [];

    currentVideo =
        result.isEmpty ? null : (await result.first?.originFile)?.path;
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
