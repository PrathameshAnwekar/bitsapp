import 'package:bitsapp/services/logger_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motion/motion.dart';

class ProfileInfoStack extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? profileDescription;
   const ProfileInfoStack({super.key, required this.name, this.imageUrl, this.profileDescription});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 70,
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              shadowColor: Colors.grey.withOpacity(0.5),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.only(top: 80),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      profileDescription ?? "Your friendly neighbourhood bitsian",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.45),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 75,
            backgroundColor: const Color(0xFF69708C).withOpacity(0.2),
            child:  CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              backgroundImage: CachedNetworkImageProvider(
                imageUrl ?? "https://picsum.photos/200",
                errorListener: () {
                  elog("Error loading image");
                },
                cacheKey: "localUser.profilePicUrl"
              ),
            ),
          ),
        ],
      ),
    );
  }
}
