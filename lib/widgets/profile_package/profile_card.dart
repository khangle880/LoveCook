import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const ProfileCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.access_time,
                  size: 40.0,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 24.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Joined Date",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "21 August 2020",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
