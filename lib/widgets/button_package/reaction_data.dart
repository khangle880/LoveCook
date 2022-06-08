import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import '../../gen/assets.gen.dart';

Container _buildTitle(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Padding _buildReactionsPreviewIcon(String path) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
    child: Image.asset(path, height: 40),
  );
}

Image _buildIcon(String path) {
  return Image.asset(
    path,
    height: 30,
    width: 30,
  );
}

Container _buildReactionsIcon(String path, Text text) {
  return Container(
    color: Colors.transparent,
    child: Row(
      children: <Widget>[
        Image.asset(path, height: 20),
        const SizedBox(width: 5),
        text,
      ],
    ),
  );
}

final reactions = [
  Reaction<String>(
    value: 'Empty',
    title: _buildTitle('Empty'),
    previewIcon: _buildReactionsPreviewIcon(Assets.images.png.empty.path),
    icon: _buildReactionsIcon(
      Assets.images.png.empty.path,
      Text(
        'Reaction',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Happy',
    title: _buildTitle('Happy'),
    previewIcon: _buildReactionsPreviewIcon(Assets.images.png.happy.path),
    icon: _buildReactionsIcon(
      Assets.images.png.happy.path,
      Text(
        'Happy',
        style: TextStyle(
          color: Color(0XFF3b5998),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Angry',
    title: _buildTitle('Angry'),
    previewIcon: _buildReactionsPreviewIcon(Assets.images.png.angry.path),
    icon: _buildReactionsIcon(
      Assets.images.png.angry.path,
      Text(
        'Angry',
        style: TextStyle(
          color: Color(0XFFed5168),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'In love',
    title: _buildTitle('In love'),
    previewIcon: _buildReactionsPreviewIcon(Assets.images.png.inLove.path),
    icon: _buildReactionsIcon(
      Assets.images.png.inLove.path,
      Text(
        'In love',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Sad',
    title: _buildTitle('Sad'),
    previewIcon: _buildReactionsPreviewIcon(Assets.images.png.sad.path),
    icon: _buildReactionsIcon(
      Assets.images.png.sad.path,
      Text(
        'Sad',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Surprised',
    title: _buildTitle('Surprised'),
    previewIcon: _buildReactionsPreviewIcon(Assets.images.png.surprised.path),
    icon: _buildReactionsIcon(
      Assets.images.png.surprised.path,
      Text(
        'Surprised',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Mad',
    title: _buildTitle('Mad'),
    previewIcon: _buildReactionsPreviewIcon(Assets.images.png.mad.path),
    icon: _buildReactionsIcon(
      Assets.images.png.mad.path,
      Text(
        'Mad',
        style: TextStyle(
          color: Color(0XFFf05766),
        ),
      ),
    ),
  ),
];
