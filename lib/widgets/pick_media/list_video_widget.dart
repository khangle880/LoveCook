import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'video_widget.dart';

class ListVideoWidget extends StatefulWidget {
  const ListVideoWidget({Key? key}) : super(key: key);

  @override
  State<ListVideoWidget> createState() => _ListVideoWidgetState();
}

class _ListVideoWidgetState extends State<ListVideoWidget> {
  String linkFormater(String url) {
    return "http://192.168.43.131:5000$url";
  }

  List<String> videoUrls = [];
  @override
  void initState() {
    getVideos();
    super.initState();
  }

  void getVideos() async {
    final url = Uri.parse("http://192.168.43.131:5000/videos");
    var response = await http.get(url);
    var decoded = json.decode(response.body);
    videoUrls = decoded.map<String>((item) => item['url'] as String).toList();
    log(videoUrls.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: videoUrls.map((e) {
          log(linkFormater(e));
          return Expanded(
            child: VideoWidget(
              path: linkFormater(e),
            ),
          );
        }).toList(),
      ),
    );
  }
}
