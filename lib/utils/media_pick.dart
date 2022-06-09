import 'package:flutter/cupertino.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

Future<List<String>> multiImagePick(BuildContext context) async {
  return mediaPick(context: context, requestType: RequestType.image);
}

Future<List<String>> multiVideoPick(BuildContext context) async {
  return mediaPick(context: context, requestType: RequestType.video);
}

Future<String?> singleImagePick(BuildContext context) async {
  return mediaPick(
    context: context,
    requestType: RequestType.image,
    maxAssetsCount: 1,
  ).then((value) => value.isEmpty ? null : value.first);
}

Future<String?> singleVideoPick(BuildContext context) async {
  return mediaPick(
    context: context,
    requestType: RequestType.video,
    maxAssetsCount: 1,
  ).then((value) => value.isEmpty ? null : value.first);
}

Future<List<String>> mediaPick({
  required BuildContext context,
  required RequestType requestType,
  int maxAssetsCount = 9,
}) async {
  final List<AssetEntity> result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          requestType: requestType,
          maxAssets: maxAssetsCount,
        ),
      ) ??
      [];

  return Future.wait(result.map((e) async {
    return (await e.originFile)?.path;
  })).then((value) => List.from(value.where((element) => element != null)));
}
