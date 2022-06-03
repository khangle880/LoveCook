import 'dart:typed_data';

class ImageData {
  String? fileName;
  Uint8List byteData;

  ImageData({
     this.fileName,
    required this.byteData,
  });
}
