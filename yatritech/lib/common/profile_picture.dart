import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ProfilePicture({super.key, required this.scaffoldKey});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.scaffoldKey.currentState?.openEndDrawer();
      },

      child: ClipOval(
        child: Image.network(
          "https://picsum.photos/240",
          width: 40.9,
          height: 40.9,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
