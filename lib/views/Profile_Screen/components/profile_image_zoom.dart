import 'package:flutter/material.dart';

showPopUp(String imageUrl, BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          height: 500,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Image border
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
      );
    },
  );
}
