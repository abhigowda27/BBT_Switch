import 'package:flutter/material.dart';
import '../constants.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({required this.heading, super.key});
  final String heading;
  // bool? isBack = false;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        iconTheme: IconThemeData(color: appBarColour),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        backgroundColor: backGroundColour,
        // automaticallyImplyLeading: false,
        title: Text(
          heading,
          style: TextStyle(
              color: appBarColour, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
