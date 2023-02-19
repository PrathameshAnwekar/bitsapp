import 'package:flutter/material.dart';

class ExperienceWidget extends StatelessWidget {
  final String url;
  final String txt1;
  final String txt2;
  final String txt3;
  const ExperienceWidget(
      {super.key,
      required this.url,
      required this.txt1,
      required this.txt2,
      required this.txt3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 70,
            child: Image.network(url),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                txt1,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text(
                txt2,
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              txt3 == ""
                  ? const SizedBox()
                  : Text(
                      txt3,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
