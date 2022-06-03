import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../enums.dart';
import 'list_tile_widget.dart';

class PickMediaButton extends StatefulWidget {
  const PickMediaButton({Key? key, required this.source}) : super(key: key);

  final ImageSource source;

  @override
  State<PickMediaButton> createState() => _PickMediaButtonState();
}

class _PickMediaButtonState extends State<PickMediaButton> {
  @override
  Widget build(BuildContext context) => ListTileWidget(
        text: widget.source == ImageSource.gallery
            ? "From gallery"
            : "From camera",
        icon: Icons.photo,
        onClicked: () => pickGalleryMedia(context),
      );

  Future pickGalleryMedia(BuildContext context) async {
    final MediaSource source = (ModalRoute.of(context)?.settings.arguments ??
        MediaSource.image) as MediaSource;

    final getMedia = source == MediaSource.image
        ? ImagePicker().pickImage
        : ImagePicker().pickVideo;

    final media = await getMedia(source: widget.source);
    if (media == null) return;
    final file = File(media.path);
    if (!mounted) return;
    Navigator.of(context).pop(file);
  }
}
