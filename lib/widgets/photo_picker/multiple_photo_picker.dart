import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../multi_image_picker/multi_image_picker.dart';
import 'add_photo_widget.dart';
import 'image_data.dart';
import 'photo_item.dart';

class PickPhotoController {
  final List<dynamic> _images = [];

  List<dynamic> get images => _images;

  set images(List<dynamic> value) {
    _images.clear();
    _images.addAll(value);
  }

  void dispose() {
    images.clear();
  }
}

class MultiplePhotoPicker extends StatefulWidget {
  final bool? status;
  final int maxImageSelection;
  final bool disable;
  final String? errorMessage;
  final bool isShowAddPhoto;
  final double quality;
  final double imageSize;
  final PickPhotoController controller;
  final VoidCallback? onAddImageStart;
  final Function(List<ImageData>)? onAddImageFinish;
  final Function(int)? onDeletedImage;

  const MultiplePhotoPicker({
    Key? key,
    this.status,
    required this.controller,
    this.onAddImageStart,
    this.onAddImageFinish,
    this.errorMessage,
    this.maxImageSelection = 5,
    this.isShowAddPhoto = true,
    this.disable = false,
    this.onDeletedImage,
    this.quality = 70,
    this.imageSize = 44,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhotoPickPhotoUpdateListState();
  }
}

class _PhotoPickPhotoUpdateListState extends State<MultiplePhotoPicker> {
  @override
  Widget build(BuildContext context) {
    return _showImageList(context);
  }

  Widget _showImageList(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...widget.controller.images
                .mapIndexed(
                  (imageData, index) => Row(
                    children: [
                      PhotoItem(
                        size: widget.imageSize,
                        disable: widget.disable,
                        dataImage: imageData,
                        onDeleteImageClick: (data) {
                          _deleteImage(data);
                          widget.onDeletedImage?.call(index);
                        },
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                )
                .toList(),
            Visibility(
              visible: widget.isShowAddPhoto,
              child: AddPhotoButtonWidget(
                size: widget.imageSize,
                progress: widget.controller.images.length,
                max: widget.maxImageSelection,
                disable: widget.disable,
                onTap: widget.disable
                    ? () {}
                    : () async {
                        await _addImageFromGallery();
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteImage(dynamic imageData) {
    final index = widget.controller.images.indexOf(imageData);
    if (index >= 0) {
      widget.controller.images.removeAt(index);
      setState(() {});
    }
  }

  Future _addImageFromGallery() async {
    if (widget.controller.images.length >= widget.maxImageSelection) {
      // TODO show dialog max item selected
    } else {
      final remainImageAllowToPick =
          widget.maxImageSelection - widget.controller.images.length;

      final selectedImages = await getImageFromGallery(
        context,
        maxImage: remainImageAllowToPick,
      );

      if (selectedImages.isNotEmpty) {
        widget.onAddImageStart?.call();
        final imagesData = <ImageData>[];
        for (final selectedItem in selectedImages) {
          final bytesData = await selectedItem.getByteData(
            quality: 80,
          );
          final uInt8listData = Uint8List.sublistView(bytesData);
          widget.controller.images.insert(0, uInt8listData);

          imagesData.add(
              ImageData(byteData: uInt8listData, fileName: selectedItem.name));
        }
        widget.onAddImageFinish?.call(imagesData);
        setState(() {});
      }
    }
  }

  Future<List<Asset>> getImageFromGallery(
    BuildContext context, {
    List<Asset> selectedAssets = const [],
    int maxImage = 1,
    String? title,
  }) async {
    return await MultiImagePicker.pickImages(
      maxImages: maxImage,
      enableCamera: true,
      selectedAssets: selectedAssets,
      cupertinoOptions: const CupertinoOptions(),
      materialOptions: MaterialOptions(
        allViewTitle: title ?? '',
        startInAllView: true,
      ),
    );
  }
}
